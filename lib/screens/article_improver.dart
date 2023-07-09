import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/bloc_article_improver.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import '../blocs/provider/ocr_image_provider.dart';
import '../services/jwt_storage.dart';
import '../utils/routes.dart';
import 'package:image/image.dart' as img_package;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';


class ArticleImproverPage extends StatefulWidget{
  const ArticleImproverPage({Key?key}):super(key: key);
  @override
  State<ArticleImproverPage> createState()=> _ArticleImproverPage();
}
class _ArticleImproverPage extends State<ArticleImproverPage>{
  final _controller= TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ocrImageProvider = Provider.of<OCRImageProvider>(context);
    List<AssetEntity> images = <AssetEntity>[];

    Future<void> processImages() async {
      List<img_package.Image> loadedImages = [];
      for (AssetEntity asset in images) {
        final Uint8List? imageData = await asset.originBytes;
        if (imageData != null) {
          img_package.Image img = img_package.decodeImage(imageData)!;
          loadedImages.add(img_package.copyResize(img, width: 720));
        }
      }

      final combined = img_package.Image(
          loadedImages[0].width,
          loadedImages.fold<int>(
              0, (previousValue, element) => previousValue + element.height));

      int offset = 0;
      for (img_package.Image img in loadedImages) {
        img_package.copyInto(combined, img, dstY: offset);
        offset += img.height;
      }

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/combined.jpg';
      File(filePath).writeAsBytesSync(img_package.encodeJpg(combined));
      ocrImageProvider.set(File(filePath));
    }

    Future<void> loadAssets() async {
      List<AssetEntity>? resultList = await AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 2,
          gridCount: 4,
        ),
      );

      if (!mounted) return;

      if (resultList != null) {
        setState(() {
          images = resultList;
        });
        await processImages();
      }
    }
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text('Writing Improver',style: Theme.of(context).textTheme.bodyLarge,),
        ),
        BlocBuilder<ArticleBloc,ArticleState>(
            builder: (context,state){
              if(state.status=="INIT"){
                return Expanded(
                  flex: 8,
                  child:Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                          children:[
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text('Content',style: Theme.of(context).textTheme.bodyMedium)
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              height: 180,
                              decoration: Theme.of(context).brightness == Brightness.dark ? DarkStyle.boxDecoration : LightStyle.boxDecoration,
                              child: SingleChildScrollView(
                                child: ocrImageProvider.isNull()?
                                const TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: "可以在這寫下你的作文或使用照片",
                                    border: InputBorder.none,
                                  ),
                                ):
                                Stack(
                                    children: [
                                      Image.memory(ocrImageProvider.image as Uint8List),
                                      IconButton(onPressed: (){ocrImageProvider.clear();}, icon: const Icon(Icons.cancel_outlined,size: 30,color: Colors.red,))
                                    ]
                                ),
                              ),
                            ),

                            Container(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await JwtService.saveJwt("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY4ODE5NjYyMywianRpIjoiYmU4ZGQ2YzctMWRmNC00Nzg0LTgzOTgtZWQ5ODZhNGM5ZGM1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2ODgxOTY2MjMsImNzcmYiOiJhNjYzNzFiNS01NWUwLTRjMzAtOGRkNS0zM2E4M2FjZGI2MDkiLCJleHAiOjE2ODk0MDYyMjN9.sXF-_dRljEvsUzH7NdnKSTbQX36NTD_iOncnrcVocYY");
                                          await DefaultCacheManager().emptyCache();
                                        },
                                        icon: const Icon(Icons.adb_outlined,size: 36,)
                                    ),

                                    IconButton(
                                      onPressed:loadAssets,
                                      tooltip: 'Choose come photos.',
                                      icon:const Icon(Icons.photo),
                                      iconSize: 36.0,
                                    ),
                                    IconButton(
                                      onPressed:(){
                                        Navigator.pushNamed(context, Routes.camera);
                                      },
                                      tooltip: 'Take a photo.',
                                      icon:const Icon(Icons.camera_alt_outlined),
                                      iconSize: 36.0,
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text('Prompt',style: Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              height: 150,
                              decoration: Theme.of(context).brightness == Brightness.dark ? DarkStyle.boxDecoration : LightStyle.boxDecoration,
                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: _controller,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    hintText: "可以寫下作文主題以及你認為需加強部分\n(選填)",
                                    hintMaxLines: 3,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),

                          ]
                      ),
                    ),
                  ),
                );
              }
              else if(state.status=="PENDING"){
                return const Expanded(
                    flex:9,
                    child: Loading()
                );
              }
              else if (state.status=='SUCCESS'){
                return const Expanded(
                  flex:8,
                  child: Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline,size:40),
                          Text("Success to upload")
                        ],
                      )
                  ),
                );
              }
              else{
                return const Expanded(
                  flex:8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child:Icon(Icons.warning_rounded,size:40,color: Colors.red,)
                      ),
                      Text("Fail to upload")
                    ],
                  )
                );
              }
        }),
        BlocBuilder<ArticleBloc,ArticleState>(
          builder: (context,state){
            if(state.status=="INIT"){
              return Expanded(
                  flex: 1,
                  child:FractionallySizedBox(
                      widthFactor: 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ArticleBloc>().add(ArticleEventGraph(ArticleImage(ocrImageProvider.file,_controller.text)));
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child:const Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                      )
                  )
              );
            }
            else if(state.status=="PENDING"){
              return Container();
            }
            else{
              return Expanded(
                  flex: 1,
                  child:FractionallySizedBox(
                      widthFactor: 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          ocrImageProvider.clear();
                          context.read<ArticleBloc>().add(ArticleEventRefresh());
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child:const Text('Reset',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                      )
                  )
              );
            }
          }
        ),

      ],
    );
  }

}