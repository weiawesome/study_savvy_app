import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/session/session_cubit.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/screens/sign_up.dart';
import 'package:study_savvy_app/screens/Home.dart';
import 'package:study_savvy_app/blocs/LogIn/login_state.dart';
import 'package:study_savvy_app/blocs/LogIn/login_event.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/LogIn/login_bloc.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            // body: BlocProvider<LoginBloc>(
            //   create: (context) => LoginBloc(
            //     authRepo: context.read<AuthRepository>(),
            //     authCubit: context.read<AuthCubit>(),
            //   ),
              // child:
              body: 
              SafeArea(
                child: Column(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'StudySavvy',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //Expanded(flex:1,child: Container(),),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: _LoginForm(),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("—————————— sign up ——————————",
                                style: Theme.of(context).textTheme.bodySmall),
                            Text("Don’t have an account?",
                                style: Theme.of(context).textTheme.bodySmall),
                            TextButton(
                              onPressed: () {
                                //context.read<AuthCubit>().showSignUp();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpView()));
                              },
                              child: Text("Sign up",
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ),
                          ]))
                ]),
              ),
            //)
            );
  }

  Widget _LoginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 110,),
                      _EmailField(),
                      const SizedBox(height: 25,),
                      _PasswordField(),
                      const SizedBox(height: 210,),
                      _SignInButton(),
                    ],
                  ),
                ),
    ));
  }

  Widget _EmailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
        decoration: InputDecoration(
          hintText: 'Email',
          hintStyle:
              TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
          filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        ),
        validator: (value) => state.isValidEmail ? null : 'Invalid email address.',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _PasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle:
              TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
          filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        ),
        validator: (value) => state.isValidPassword ? null : 'Password must be at least 8 chars.',
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _SignInButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : SizedBox(
              width: 189,
              height: 49,
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  debugPrint('Click "sign in!" button');
                  if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                  if(SubmissionSuccess().test)
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: const Text(
                  'Sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Play',
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
