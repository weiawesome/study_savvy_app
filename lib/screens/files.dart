import 'dart:math';
import 'package:flutter/material.dart';
import '../styles/custom_style.dart';

class FilesPage extends StatefulWidget{
  const FilesPage({Key?key}):super(key: key);
  @override
  State<FilesPage> createState()=> _FilesPage();
}

class _FilesPage extends State<FilesPage> {
  final _items = <String>[];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2)); // simulate a delay
    _items.clear();
    _loadMore();
  }

  void _loadMore() {

    for (var i = 0; i < 15; i++) {
      List<String> options = ['SUCCESS', 'FAILURE', 'PENDING'];
      Random random = Random();
      String randomOption = options[random.nextInt(options.length)];
      _items.add(randomOption);
    }
    setState(() {});
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
            padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
            child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Files',style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              Expanded(
                flex: 9,
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                            onPressed: (){print(index);},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                              height: 100,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),border: Border.all(width: 1),color:Theme.of(context).brightness == Brightness.dark ? DarkStyle.FileBoxColor:LightStyle.FileBoxColor),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex:5,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Title',style: Theme.of(context).textTheme.bodySmall,),
                                          Text('Type',style: Theme.of(context).textTheme.bodySmall,),
                                          Text('Date_Time',style: Theme.of(context).textTheme.bodySmall,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                      children:
                                      _items[index]=='SUCCESS'?
                                      [Icon(Icons.check_circle_outline,color: Color.fromRGBO(48,219,91,1),size: 45,),Text('Finish',style: Theme.of(context).textTheme.bodySmall,)] :_items[index]=='FAILURE'?
                                      [Icon(Icons.dangerous_sharp,color: Colors.red,size: 45,),Text('Fail',style: Theme.of(context).textTheme.bodySmall,)]:
                                      [Icon(Icons.query_stats_rounded,color: Colors.yellow,size: 45,),Text('Wait',style: Theme.of(context).textTheme.bodySmall,)],

                                    ),
                                  )
                                ],

                              ),
                            ));
                      }
                  ),
                )
              ),
            ]
            )
      )
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}