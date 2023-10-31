import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/screens/signup/sign_up.dart';
import 'package:study_savvy_app/blocs/LogIn/login_state.dart';
import 'package:study_savvy_app/blocs/LogIn/login_event.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/LogIn/login_bloc.dart';
import '../../blocs/profile/bloc_online.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthRepository authRepo = AuthRepository();
  LoginState loginState = LoginState();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>(),
          ),
          child: SafeArea(
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
                  child: BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        final formStatus = state.formStatus;
                        if (formStatus is SubmissionFailed) {
                          _showSnackBar(context, formStatus.exception.toString());
                        } else if(formStatus is SubmissionSuccess){
                          context.read<OnlineBloc>().add(OnlineEventCheck());
                          Navigator.pop(context);
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 110,),
                              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                                return TextFormField(
                                  controller: emailController,
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
                              }),
                              const SizedBox(height: 25,),
                              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                                return TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  style: TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                    TextStyle(color: Theme.of(context).textTheme.titleMedium!.color),
                                    filled: true,
                                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                                  ),
                                  validator: (value) => state.isValidPassword ? null : 'Invalid password.',
                                  onChanged: (value) => context.read<LoginBloc>().add(
                                    LoginPasswordChanged(password: value),
                                  ),
                                );
                              }),
                              const SizedBox(height: 210,),
                              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                                return state.formStatus is FormSubmitting
                                    ? const CircularProgressIndicator()
                                    : SizedBox(
                                  width: 189,
                                  height: 49,
                                  child: ElevatedButton(
                                    style: Theme.of(context).elevatedButtonTheme.style,
                                    onPressed: () async {
                                      debugPrint('Click "sign in!" button');
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(LoginSubmitted());
                                        context.read<OnlineBloc>().add(OnlineEventCheck());
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
                              })
                            ],
                          ),
                        ),
                      ))
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
                            context.read<AuthCubit>().showLogin();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpView()));
                          },
                          child: Text("Sign up",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                      ]))
            ]),
          ),
        )
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
