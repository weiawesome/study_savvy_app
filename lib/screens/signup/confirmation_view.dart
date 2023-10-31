import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/confirmation/confirmation_bloc.dart';
import 'package:study_savvy_app/blocs/confirmation/confirmation_event.dart';
import 'package:study_savvy_app/blocs/confirmation/confirmation_state.dart';
import 'package:study_savvy_app/screens/signup/email_confirm.dart';

import '../../blocs/utils/bloc_navigator.dart';

class ConfirmationView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ConfirmationBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: _confirmationForm(context),
      ),
    );
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
                print("KAKA");
                print(context.read<SignUpBloc>().state.toString());
                if (_formKey.currentState!.validate()) {

                  context.read<ConfirmationBloc>().add(ConfirmationSubmitted());
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => EmailConfirm()),
                  //   );
                }
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}