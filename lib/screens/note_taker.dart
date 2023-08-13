import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/note_taker/noteTaker_state.dart';
import 'package:study_savvy_app/styles/custom_style.dart';

import '../blocs/note_taker/noteTaker_bloc.dart';
import '../blocs/note_taker/noteTaker_event.dart';
import '../blocs/provider/audio_provider.dart';
import '../models/model_noteTaker.dart';
import '../widgets/loading.dart';
import 'dart:io';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:file_picker/file_picker.dart';

class NoteTakerPage extends StatefulWidget {
  const NoteTakerPage({Key? key}) : super(key: key);

  @override
  State<NoteTakerPage> createState() => _NoteTakerPageState();
}

class _NoteTakerPageState extends State<NoteTakerPage> {
  
  final _promptController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<PlatformFile> audioFiles = [];  //store selected files
    final audioProvider = Provider.of<FileProvider>(context);

    void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Warn',style: Theme.of(context).textTheme.displayMedium),
          content: Text("內容不得為空\n請上傳音檔和文字",style: Theme.of(context).textTheme.displaySmall),
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

    Future<void> loadAudioFiles() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mpegwa'], //['mp3', 'wav'],
      allowMultiple: true,
    );

      if (result != null) {
      setState(() {
        audioFiles = result.files;
      });
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
            child: Text(
              'Note taker',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          BlocBuilder<audioBloc, audioState>(
            builder: (context, state) {
              if (state.status == "INIT") {
                return Expanded(
                  flex: 8,
                  //child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            width: 205,
                            height: 230,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xA7A7A7),
                                width: 2,
                              ),
                            ),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/images/recording.png',
                                width: 203,
                                height: 228,
                              ),
                              onPressed: loadAudioFiles,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.grey[200],
                            value: 0.5,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(20)),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    'Prompt',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  height: 121,
                                  decoration: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? DarkStyle.boxDecoration
                                      : LightStyle.boxDecoration,
                                  child: SingleChildScrollView(
                                    child: TextField(
                                      controller: _promptController,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText: "(今日課堂主題)",
                                        hintMaxLines: 3,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                          
                        // ),
                      ],
                    ),
                  //),
                );
              } else if(state.status=="PENDING"){
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
            },
          ),
          BlocBuilder<audioBloc, audioState>(
            builder: (context, state) {
              if (state.status == "INIT") {
                return Expanded(
                  flex: 1,
                  child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: ElevatedButton(
                              onPressed: () {
                                if(audioProvider.file==null){
                                  if(_promptController.text==""){
                                    _showAlertDialog(context);
                                  }
                                }
                                else{
                                  context.read<audioBloc>().add(audioChanged(noteTaker_audio(audioProvider.file,_promptController.text)));
                                }
                              },
                              child: const Text(
                                'Done',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Play',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: Theme.of(context).elevatedButtonTheme.style,
                            ),
                          ),
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
                            audioFiles = [];
                            context.read<audioBloc>().add(audioEventRefresh());
                          },
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child:const Text('Reset',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                        )
                    )
                );
              }
            })

        ],
      ),
    );
  }
}
