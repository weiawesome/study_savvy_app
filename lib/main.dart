import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/profile/bloc_access_methods.dart';
import 'package:study_savvy_app/blocs/article_improver/bloc_article_improver.dart';
import 'package:study_savvy_app/blocs/session/session_cubit.dart';
import 'package:study_savvy_app/blocs/utils/app_navigator.dart';
import 'package:study_savvy_app/blocs/utils/bloc_navigator.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/blocs/files/bloc_specific_file.dart';
import 'package:study_savvy_app/screens/home.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'blocs/LogIn/login_bloc.dart';
import 'blocs/files/bloc_files.dart';
import 'blocs/provider/audio_provider.dart';
import 'blocs/utils/bloc_jwt.dart';
import 'blocs/profile/bloc_password.dart';
import 'blocs/profile/bloc_profile.dart';
import 'blocs/provider/ocr_image_provider.dart';
import 'blocs/provider/theme_provider.dart';
import 'styles/custom_style.dart';
import 'package:study_savvy_app/screens/initial.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/note_taker/noteTaker_bloc.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          RepositoryProvider(
            create: (context) => AuthRepository(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(sessionCubit: SessionCubit(authRepo: AuthRepository())),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => OCRImageProvider(),
          ),
          BlocProvider(
            create: (context) => PageBloc(),
          ),
          BlocProvider(
            create:  (context) => JWTBloc(),
          ),
          BlocProvider(
            create:  (context) => FileBloc(),
          ),
          BlocProvider(
            create:  (context) => FilesBloc(),
          ),
          BlocProvider(
            create:  (context) => ProfileBloc(),
          ),
          BlocProvider(
            create:  (context) => AccessMethodBloc(),
          ),
          BlocProvider(
            create:  (context) => ArticleBloc(),
          ),
          BlocProvider(
            create:  (context) => PasswordBloc(),
          ),
          BlocProvider(
              create: (context) => LoginBloc(authRepo: context.read<AuthRepository>(), authCubit: AuthCubit(sessionCubit: SessionCubit(authRepo: AuthRepository())))
          ),
          BlocProvider(
              create: (context) => SignUpBloc(authRepo: context.read<AuthRepository>(), authCubit: context.read<AuthCubit>())
          ),
          BlocProvider(
            create:  (context) => PasswordBloc(),
          ),
          BlocProvider(
            create:  (context) => OnlineBloc(),
          ),
          BlocProvider(
              create: (context) => LoginBloc(authRepo: context.read<AuthRepository>(), authCubit: AuthCubit(sessionCubit: SessionCubit(authRepo: AuthRepository())))
          ),
          BlocProvider(
              create: (context) => SignUpBloc(authRepo: context.read<AuthRepository>(), authCubit: context.read<AuthCubit>())
          ),
          BlocProvider(
            create:  (context) => PasswordBloc(),
          ),
          BlocProvider(
            create:  (context) => OnlineBloc(),
          ),
          BlocProvider(
            create:  (context)
            => SessionCubit(authRepo: context.read<AuthRepository>(),),
            child: AppNavigator(), //responsible for showing the view
          ),
          BlocProvider(
            create:  (context) => audioBloc(),
          ),
          ChangeNotifierProvider(
            create: (_) => FileProvider(),
          ),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    context.read<OnlineBloc>().add(OnlineEventCheck());
    return BlocBuilder<OnlineBloc,OnlineState>(
      builder: (context,state){
        if(state.status==true){
          return MaterialApp(
              title: 'Study-Savvy',
              theme: LightStyle.theme,
              darkTheme: DarkStyle.theme,
              themeMode: themeProvider.themeMode,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              home:const MenuHome()
          );
        } else if (state.status==false){
          return MaterialApp(
              title: 'Study-Savvy',
              theme: LightStyle.theme,
              darkTheme: DarkStyle.theme,
              themeMode: themeProvider.themeMode,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              home:const HomePage()
          );
        } else{
          return MaterialApp(
              title: 'Study-Savvy',
              theme: LightStyle.theme,
              darkTheme: DarkStyle.theme,
              themeMode: themeProvider.themeMode,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
              home: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image:  (themeProvider.themeMode == ThemeMode.light) || (themeProvider.themeMode == ThemeMode.system)
                      ? const AssetImage('assets/images/initial_white.jpg') : const AssetImage('assets/images/initial.jpg'), fit: BoxFit.cover)
                )
              )
          );
      }
      },

    );
  }
}