import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_bloc.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_state.dart';

enum gender { Male, Female, others }
class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocProvider(
        create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: 
        //body:
        //Stack(
          SafeArea( child:
          Column(
          //alignment: Alignment.bottomCenter,
          children: [
            Expanded(flex:2, child: _topbar(context)),
            Expanded(flex:11, child:_signUpForm()),
            //Expanded(flex:2, child:_showLoginButton(context)),
          ],
          )
          )
        //),
      ),
    );
  }
 
  Widget _topbar(BuildContext context){
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                  Expanded(flex: 1, 
                    child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new, color:Theme.of(context).textTheme.bodyLarge!.color),
                            onPressed: () => Navigator.of(context).pop(),
                  )),
                  Expanded(
                    flex: 5,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            'StudySavvy',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(flex:1,child: Container(),),
                      ],
                    ),)
    ]),);
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailField(),
                _usernameField(),
                _passwordField(),
                _ConfirmPasswordField(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  child: _signUpButton()),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Username',
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpUsernameChanged(username: value),
            ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Email',
        ),
        validator: (value) => state.isValidUsername ? null : 'Invalid email',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _ConfirmPasswordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confirm Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordChanged(password: value),
            ),
      );
    });
  }

  

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : 
          SizedBox(
            width: 189,
            height: 49,
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
                  }
                },
                child: Text('Sign Up',
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

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text('Already have an account? Sign in.'),
        onPressed: () => context.read<AuthCubit>().showLogin(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}