import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailConfirm extends StatefulWidget {
  const EmailConfirm({super.key});

  @override
  State<EmailConfirm> createState() => _EmailConfirmState();
}

class _EmailConfirmState extends State<EmailConfirm> {
  @override
  Widget build(BuildContext context) {
    return Column(
       children: [
        Center(
          child: Text(
            "StudySavvy",
            ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            "Your mail has been certified successfully",
            ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            "You can now use all features",
            ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            "Press \"Confirm\" to return to the login",
            ),
        ),
        SizedBox(height: 5),
        Icon(
          FontAwesomeIcons.cakeCandles,
          color: Colors.white,
          size: 50,
        ),
        SizedBox(
          width: 189,
          height: 49,
          child: ElevatedButton(
            style: ButtonStyle(
              //foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Color(0xFF767680)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
            ))),          
            onPressed: (){
            debugPrint('sign in!');
            }, 
            child: const Text(
            'Sign in',
            style: TextStyle(fontFamily: 'Play', fontSize: 25),
            )
          ),
         ),

       ],
    );
  }
}