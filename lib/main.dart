import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_navigator.dart';
import 'package:study_savvy_app/blocs/profile/bloc_access_methods.dart';
import 'package:study_savvy_app/blocs/article_improver/bloc_article_improver.dart';
import 'package:study_savvy_app/blocs/session/session_cubit.dart';
import 'package:study_savvy_app/blocs/session/session_state.dart';
import 'package:study_savvy_app/blocs/utils/app_navigator.dart';
import 'package:study_savvy_app/blocs/utils/bloc_navigator.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/blocs/files/bloc_specific_file.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'blocs/LogIn/login_bloc.dart';
import 'blocs/files/bloc_files.dart';
import 'blocs/utils/bloc_jwt.dart';
import 'blocs/profile/bloc_password.dart';
import 'blocs/profile/bloc_profile.dart';
import 'blocs/provider/ocr_image_provider.dart';
import 'blocs/provider/theme_provider.dart';
import 'styles/custom_style.dart';
import 'package:study_savvy_app/screens/initial.dart';
import 'package:study_savvy_app/screens/sign_in.dart';
 import 'package:study_savvy_app/screens/sign_up.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';

void main() {
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
            providers: [
              RepositoryProvider(
                create: (context) => AuthRepository(),
              ),
              BlocProvider(
                create: (context) => AuthCubit(sessionCubit: SessionCubit(authRepo: AuthRepository())), // 创建 AuthCubit 提供者
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
              // RepositoryProvider(
              //   create: (context) => LoginBloc(authRepo: context.read<AuthRepository>(), authCubit: context.read<AuthCubit>()),
              //   child: SignInPage(),
              // ),
                BlocProvider(
                  create: (context) => LoginBloc(authRepo: context.read<AuthRepository>(), authCubit: AuthCubit(sessionCubit: SessionCubit(authRepo: AuthRepository())))
                ),
                // RepositoryProvider(
                //   create: (context) => SignUpBloc(authRepo: context.read<AuthRepository>(), authCubit: context.read<AuthCubit>()),
                //   child: SignUpView(),
                // ),
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
            ],
            child: const MyApp(),
          )
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return 
    // RepositoryProvider(
    //   create: (context) => AuthRepository(),
    //   child: 
      MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Study-Savvy',
        theme: LightStyle.theme,
        darkTheme: DarkStyle.theme,
        themeMode: themeProvider.themeMode,
         //initialRoute: Routes.home,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        home: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/initial.jpg'),
            fit: BoxFit.cover,
          )),
          child: const HomePage(),

        )
      //)
      );
  }
}
