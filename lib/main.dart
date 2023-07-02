import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/bloc_navigator.dart';
import 'package:study_savvy_app/blocs/bloc_specific_file.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'blocs/bloc_files.dart';
import 'blocs/bloc_jwt.dart';
import 'blocs/bloc_profile.dart';
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
              )
            ],
            child: MyApp(),
          )
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: LightStyle.theme,
      darkTheme: DarkStyle.theme,
      themeMode: themeProvider.themeMode,
      initialRoute: Routes.Home,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
