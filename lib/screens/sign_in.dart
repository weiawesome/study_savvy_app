import 'package:flutter/material.dart';
import 'package:study_savvy_app/styles/custom_style.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF202124);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Play',
        appBarTheme: AppBarTheme(
          color: primaryColor,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'StudySavvy',
            style: TextStyle(
              //fontFamily: 'Play',
              fontSize: 36.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          //automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },),
        ),
        body: _LoginForm(),
    ));
  }
  
  Widget _LoginForm(){
    return Form(
      key:_formKey,
      child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _EmailField(),
                SizedBox(height: 16,),
                _PasswordField(),
                _SignInButton(),
              ],
            ), 
        ),);
  }

  Widget _EmailField(){
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: const InputDecoration(
      hintText: 'Email',
      hintStyle: TextStyle(color: Color.fromRGBO(235, 235, 245, 0.60)),
      filled: true,
      fillColor: Color.fromRGBO(118, 118, 128, 0.24),
      ),
      validator:(value) => null,
    );
  }

  Widget _PasswordField(){
    return TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: const InputDecoration(
      hintText: 'Password',
      hintStyle: TextStyle(color: Color.fromRGBO(235, 235, 245, 0.60)),
      filled: true,
      fillColor: Color.fromRGBO(118, 118, 128, 0.24),
      ),
      validator:(value) => null,
    );
  }

  Widget _SignInButton(){
    return SizedBox(
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
    );
  }
}
