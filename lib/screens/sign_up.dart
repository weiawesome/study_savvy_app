import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_bloc.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_state.dart';
import 'package:study_savvy_app/screens/confirmation_view.dart';

import '../widgets/failure.dart';
import '../widgets/loading.dart';
import '../widgets/success.dart';


class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: 
      // BlocProvider(
      //   create: (context) => SignUpBloc(
      //     authRepo: context.read<AuthRepository>(),
      //     authCubit: context.read<AuthCubit>(),
      //   ),
        //child: 
        SafeArea(
          child: Column(
            children: [
              Expanded(flex: 2, child: _topbar(context)),
              BlocBuilder<SignUpBloc,SignUpState>(
                  builder: ((context, state) {
                    if(state.formStatus=="INIT"){
                      return Expanded(flex: 11, child: _signUpForm());
                    }
                    else if(state.formStatus=="PENDING"){
                      return const Expanded(
                        flex:9,
                        child: Loading(),
                      );
                    }
                    else if(state.formStatus=="SUCCESS"){
                      return const Expanded(
                        flex:8,
                        child: Success(message: "Success to update Password",),
                      );
                    }
                    else if(state.formStatus=="FAILURE"){
                      return Expanded(
                        flex:8,
                        child: Failure(error: state.formStatus,),
                      );
                    }
                    else{
                      return Container();
                    }
                  }
                )
  
              ),
              
            ],
          
          ),
        ),
      );
    //);
  }

  Widget _topbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,
                color: Theme.of(context).textTheme.bodyLarge!.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'StudySavvy',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) { //改
          _showSnackBar(context, formStatus);
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              _usernameField(),
              _passwordField(),
              _ConfirmPasswordField(),
              Container(  //純文字"Gender"
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text("Gender", style: Theme.of(context).textTheme.displayMedium,)),
                    Expanded(flex:8, child: Container())
                  ],
                ),
              ),
              _genderSelector(),  
              Container(  //button
                margin: const EdgeInsets.only(top: 80),
                child: _signUpButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
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
        decoration: const InputDecoration(
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
        decoration: const InputDecoration(
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
        decoration: const InputDecoration(
          hintText: 'Confirm Password',
        ),
        validator: (value) {
          if (value != state.password) {
          return 'Password confirmation failed.';
          }
        return null;
        },
            //state.isValidConfirmPassword ? null : 'Password confirmation failed.',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpConfirmPasswordChanged(confirmPassword: value),
            ),
      );
    });
  }
  
  
  Widget _genderSelector(){
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
    return Container(
      width: 312,
      height: 50,
      child: CupertinoSegmentedControl(
        children: <int, Widget>{
          0: Center(child: Text("Male", style: Theme.of(context).textTheme.bodySmall)),
          1: Center(child: Text("Female", style: Theme.of(context).textTheme.bodySmall)),
          2: Center(child: Text("Others", style: Theme.of(context).textTheme.bodySmall)),
        }, 
        groupValue: _currentIndex, //當前選中的
        //點擊回調
        onValueChanged: (int index){
          print("當前選中 $index");
          setState(() {
            _currentIndex = index;
          });
          String selectedGender = _getGenderFromIndex(index);
          context.read<SignUpBloc>().add(SignUpGenderChanged(gender: selectedGender));
        },
        selectedColor: Theme.of(context).textTheme.labelLarge!.color, //選中的背景
        unselectedColor: Theme.of(context).textTheme.titleLarge!.color, //未選中的背景
        borderColor: Theme.of(context).textTheme.titleMedium!.color, //編筐
        pressedColor: Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.4),
        ),
    );
  }
  );}

  String _getGenderFromIndex(int index) {
  switch (index) {
    case 0:
      return "Male";
    case 1:
      return "Female";
    case 2:
      return "Others";
    default:
      return "Male";
    }
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : SizedBox(
              width: 189,
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //context.read<SignUpBloc>().add(SignUpSubmitted());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConfirmationView()),
                    );
                  }
                },
                child: const Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Play',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
    });
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: const Text('Already have an account? Sign in.'),
        onPressed: () => context.read<AuthCubit>().showLogin(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
