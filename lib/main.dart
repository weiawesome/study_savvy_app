import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/profile/bloc_access_methods.dart';
import 'package:study_savvy_app/blocs/article_improver/bloc_article_improver.dart';
import 'package:study_savvy_app/blocs/utils/bloc_navigator.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/blocs/files/bloc_specific_file.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'blocs/files/bloc_files.dart';
import 'blocs/utils/bloc_jwt.dart';
import 'blocs/profile/bloc_password.dart';
import 'blocs/profile/bloc_profile.dart';
import 'blocs/provider/ocr_image_provider.dart';
import 'blocs/provider/theme_provider.dart';
import 'styles/custom_style.dart';


void main() {
  runApp(
      DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MultiProvider(
            providers: [
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
                create:  (context) => OnlineBloc(),
              )
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
    context.read<OnlineBloc>().add(OnlineEventCheck());
    return BlocBuilder<OnlineBloc,OnlineState>(
        builder: (context,state){
          if(state.status==true){
            return MaterialApp(
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              title: 'Study-Savvy',
              theme: LightStyle.theme,
              darkTheme: DarkStyle.theme,
              themeMode: themeProvider.themeMode,
              initialRoute: Routes.home,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
            );
          }
          else if(state.status==false){
            return MaterialApp(
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              title: 'Study-Savvy',
              theme: LightStyle.theme,
              darkTheme: DarkStyle.theme,
              themeMode: themeProvider.themeMode,
              initialRoute: Routes.apikey,
              onGenerateRoute: RouteGenerator.generateRoute,
              debugShowCheckedModeBanner: false,
            );
          }
          else{
            return const Loading();
          }
        }
    );
  }
}
