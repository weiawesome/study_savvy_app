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
        const Center(child: Text("StudySavvy",),),
        const SizedBox(height: 5),
        const Center(child: Text("Your mail has been certified successfully",),),
        const SizedBox(height: 5),
        const Center(child: Text("You can now use all features",),),
        const SizedBox(height: 5),
        const Center(child: Text("Press \"Confirm\" to return to the login",),),
        const SizedBox(height: 5),
        const Icon(
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
              backgroundColor: MaterialStateProperty.all(const Color(0xFF767680)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
            ))),          
            onPressed: (){
            debugPrint('sign in!');
            }, 
            child: const Text(
            'Confirm',
            style: TextStyle(fontFamily: 'Play', fontSize: 25),
            )
          ),
         ),

       ],
    );
  }
}