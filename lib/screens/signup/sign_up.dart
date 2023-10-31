import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_bloc.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_state.dart';
import 'package:study_savvy_app/models/model_signup.dart';
import 'package:study_savvy_app/screens/sign_in/sign_in.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/auth/auth_repository.dart';
import '../../blocs/confirmation/confirmation_bloc.dart';
import '../../blocs/confirmation/confirmation_event.dart';
import '../../blocs/confirmation/confirmation_state.dart';
import '../../widgets/loading.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  late SignUpModel signupModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body:
        SafeArea(
          child: Column(
            children: [
              Expanded(flex: 2, child: _topBar(context)),
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
                      return Expanded(
                        flex:8,
                        child: BlocProvider(
                          create: (context) => ConfirmationBloc(
                            authRepo: context.read<AuthRepository>(),
                            authCubit: context.read<AuthCubit>(),
                          ),
                          child: _confirmationForm(context),
                        ),
                      );
                    }
                    else if(state.formStatus=="FAILURE"){
                      return Expanded(
                        flex:8,
                        child: CupertinoAlertDialog(
                          title: Text('Alert',style: Theme.of(context).textTheme.displayMedium),
                          content: const Text('Already have an account? Sign in.'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('confirm',style: Theme.of(context).textTheme.displaySmall,),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    else if(state.formStatus=="SUCCESS_SIGNUP"){
                      return Expanded(
                        flex:8,
                        child: CupertinoAlertDialog(
                          title: Text('Success to signup',style: Theme.of(context).textTheme.displayMedium),
                          content: const Text('Go to Sign in!!!'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('confirm',style: Theme.of(context).textTheme.displaySmall,),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                              },
                            ),
                          ],
                        ),
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

  Widget _topBar(BuildContext context) {
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
              _confirmPasswordField(),
              Container(
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

  Widget _confirmPasswordField() {
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
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpConfirmPasswordChanged(confirmPassword: value),
            ),
      );
    });
  }
  
  
  Widget _genderSelector(){
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
    return SizedBox(
      width: 312,
      height: 50,
      child: CupertinoSegmentedControl(
        children: <int, Widget>{
          0: Center(child: Text("Male", style: Theme.of(context).textTheme.bodySmall)),
          1: Center(child: Text("Female", style: Theme.of(context).textTheme.bodySmall)),
          2: Center(child: Text("Others", style: Theme.of(context).textTheme.bodySmall)),
        }, 
        groupValue: _currentIndex, //當前選中的
        onValueChanged: (int index){
          setState(() {
            _currentIndex = index;
          });
          String selectedGender = _getGenderFromIndex(index);
          context.read<SignUpBloc>().add(SignUpGenderChanged(gender: selectedGender));
        },
        selectedColor: Theme.of(context).textTheme.labelLarge!.color,
        unselectedColor: Theme.of(context).textTheme.titleLarge!.color,
        borderColor: Theme.of(context).textTheme.titleMedium!.color,
        pressedColor: Theme.of(context).textTheme.titleMedium!.color!.withOpacity(0.4),
        ),
    );
  }
  );}

  String _getGenderFromIndex(int index) {
  switch (index) {
    case 0:
      return "male";
    case 1:
      return "female";
    case 2:
      return "other";
    default:
      return "male";
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
                    signupModel=SignUpModel(_getGenderFromIndex(_currentIndex),state.email,state.username,state.password);
                    context.read<SignUpBloc>().add(SignUpSubmitted(model:signupModel));
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _confirmationForm(BuildContext context) {
    return BlocListener<ConfirmationBloc, ConfirmationState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please check your email\nfor\nthe confirmation message.",
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: _codeField()),
                _confirmButton(),
              ],
            ),
          ),
        ));
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
          return TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.cookie_rounded),
              hintText: 'Confirmation Code',
            ),
            validator: (value) =>
            state.isValidCode ? null : 'Invalid confirmation code',
            onChanged: (value) => context.read<ConfirmationBloc>().add(
              ConfirmationCodeChanged(code: value),
            ),
          );
        });
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
            onPressed: () {
              context.read<SignUpBloc>().add(SignUpVerify(model: signupModel, code: state.code));
            },
            child: const Text(
              'Confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontFamily: 'Play',
                fontWeight: FontWeight.bold,
              ),),
          );
        });
  }
}
