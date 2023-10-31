import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/provider/theme_provider.dart';
import 'package:study_savvy_app/screens/sign_in/sign_in.dart';
import 'package:study_savvy_app/screens/signup/sign_up.dart';
import '../blocs/SignUp/sign_up_bloc.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return  Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
              image:  (themeProvider.themeMode == ThemeMode.light) || (themeProvider.themeMode == ThemeMode.system)
                  ? const AssetImage('assets/images/initial_white.jpg')
                  : const AssetImage('assets/images/initial.jpg'),
              fit: BoxFit.cover,
            )),
        child: Container(
            margin: const EdgeInsets.only(top: 400.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  SizedBox(
                    width: 189,
                    height: 49,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                        elevation: MaterialStateProperty.all(5),
                      ),
                      child: Text(
                        'Sign in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                          fontSize: 23,
                          fontFamily: 'Play',
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const SignInPage()));
                      },
                    ),
                  ),


                  const SizedBox(height: 16),

                  SizedBox(
                      width: 189,
                      height: 49,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                          elevation: MaterialStateProperty.all(5),
                        ),
                        child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                              fontSize: 23,
                              fontFamily: 'Play',
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        onPressed: () {
                          context.read<SignUpBloc>().add(SignUpEventReset());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUpView()));
                        },
                      )
                  ),
                ]
            )
        )
    );
  }
}
