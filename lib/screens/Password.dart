import 'package:flutter/material.dart';
class PasswordPage extends StatefulWidget{
  const PasswordPage({Key?key}):super(key: key);
  @override
  State<PasswordPage> createState()=> _PasswordPage();
}

class _PasswordPage extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child:Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:1,child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new),alignment: Alignment.bottomLeft,)),
                        Expanded(flex:5,child: Text('Password',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                        Expanded(flex:1,child: Container()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child:Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex:4,
                                  child: Text('Password:',style: Theme.of(context).textTheme.displayMedium,)
                              ),
                              Expanded(
                                flex:6,
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      hintText: "Enter the Pawssword",
                                      hintMaxLines: 3,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex:4,
                                  child: Text('New\nPassword:',style: Theme.of(context).textTheme.displayMedium,)
                              ),
                              Expanded(
                                  flex:6,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "Enter new Pawssword",
                                        hintMaxLines: 1,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex:4,
                                  child: Text('Confirm\nNew\nPassword:',style: Theme.of(context).textTheme.displayMedium,)
                              ),
                              Expanded(
                                  flex:6,
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "Confirm new Pawssword",
                                        hintMaxLines: 3,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child:FractionallySizedBox(
                          widthFactor: 0.5,
                          child: ElevatedButton(
                            onPressed: () {  },
                            child:Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                            style: Theme.of(context).elevatedButtonTheme.style,
                          )
                      )
                  ),
                ],
              )
          )
      ),
    );
  }
}