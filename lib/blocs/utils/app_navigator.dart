import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_navigator.dart';
import 'package:study_savvy_app/screens/loading_view.dart';
import 'package:study_savvy_app/blocs/session/session_cubit.dart';
import 'package:study_savvy_app/blocs/session/session_state.dart';
//import 'package:study_savvy_app/session_view.dart';
import 'package:study_savvy_app/screens/home.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),   //記得加initial page
              ),
            ),

          // Show session flow
          if (state is Authenticated) MaterialPage(child: HomePage())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}