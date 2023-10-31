import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_savvy_app/screens/sign_in/sign_in.dart';

class EmailConfirm extends StatefulWidget {
  const EmailConfirm({super.key});

  @override
  State<EmailConfirm> createState() => _EmailConfirmState();
}

class _EmailConfirmState extends State<EmailConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
         children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 45),
            child: Text("StudySavvy",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,),),
          Container(
            margin: EdgeInsets.only(top:30),
            child: Text("Your mail has been certified successfully",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,),),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text("You can now use all features",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,),),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Text("Press \"Confirm\" to return to\nthe login",
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,),),
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 20),
            child: Icon(
              FontAwesomeIcons.cakeCandles,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 160,
          ),),
          Container(
            margin: EdgeInsets.symmetric(vertical: 60),
            child:SizedBox(
              width: 189,
              height: 49,
              child: ElevatedButton(          
                onPressed: (){
                  debugPrint('read email confirmation');
                  Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => SignInPage()));
                }, 
                child: const Text(
                'Confirm',
                textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Play',
                        fontWeight: FontWeight.bold,
                      ),
    
                )
              ),),
           ),
    
         ],
      )
      ),
    );
  }
}