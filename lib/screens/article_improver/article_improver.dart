import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/article_improver/bloc_article_improver.dart';
import 'package:study_savvy_app/models/article_improver/model_article_improver.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/blocs/provider/ocr_image_provider.dart';
import 'package:study_savvy_app/utils/routes.dart';
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
  final _promptController= TextEditingController();
  final _contentController= TextEditingController();
  @override
  void dispose() {
    _promptController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Warn',style: Theme.of(context).textTheme.displayMedium),
          content: Text("Content 內容不得為空\n至少選擇圖檔或是文字",style: Theme.of(context).textTheme.displaySmall),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('confirm',style: Theme.of(context).textTheme.displaySmall),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final ocrImageProvider = Provider.of<OCRImageProvider>(context);
    List<AssetEntity> images = <AssetEntity>[];

    Future<void> processImages() async {
      ocrImageProvider.setStatus(false);
      ocrImageProvider.closeStatusFuture();
      try{
        List<img_package.Image> loadedImages = [];
        for (AssetEntity asset in images) {
          File? file = await asset.file;
          if(file!=null){
            Uint8List? imageData = await FlutterImageCompress.compressWithFile(
              file.absolute.path,
              autoCorrectionAngle: true,
            );
            if (imageData != null) {
              img_package.Image img = img_package.decodeImage(imageData)!;
              loadedImages.add(img_package.copyResize(img, width: asset.width));
            }
          }
        }
        final combined = img_package.Image(
            loadedImages[0].width,
            loadedImages.fold<int>(0, (previousValue, element) => previousValue + element.height)
        );

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
      catch (e){
        throw Exception("Error to choose image");
      }
      finally{
        ocrImageProvider.setStatus(true);
      }
    }

    Future<void> loadAssets() async {
      List<AssetEntity>? resultList = await AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 2,
          gridCount: 4,
          requestType: RequestType.image,
          keepScrollOffset: true
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

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Column(
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
                                  child: ocrImageProvider.status==false?
                                  const Loading() :ocrImageProvider.isNull()?
                                  TextField(
                                    controller: _contentController,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
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
                                    controller: _promptController,
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
                            if(ocrImageProvider.file==null){
                              if(_contentController.text==""){
                                _showAlertDialog(context);
                              }
                              else{
                                context.read<ArticleBloc>().add(ArticleEventText(ArticleText(_contentController.text,_promptController.text)));
                              }
                            }
                            else{
                              context.read<ArticleBloc>().add(ArticleEventGraph(ArticleImage(ocrImageProvider.file,_promptController.text)));
                            }

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
                            _promptController.text="";
                            _contentController.text="";
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
      ),
    );
  }

}