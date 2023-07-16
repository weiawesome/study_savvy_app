import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/profile/bloc_access_methods.dart';
import 'package:study_savvy_app/blocs/article_improver/bloc_article_improver.dart';
import 'package:study_savvy_app/blocs/files/bloc_files.dart';
import 'package:study_savvy_app/blocs/utils/bloc_jwt.dart';
import 'package:study_savvy_app/blocs/utils/bloc_navigator.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/blocs/profile/bloc_password.dart';
import 'package:study_savvy_app/blocs/profile/bloc_profile.dart';
import 'package:study_savvy_app/blocs/files/bloc_specific_file.dart';
import 'package:study_savvy_app/blocs/provider/ocr_image_provider.dart';
import 'package:study_savvy_app/blocs/provider/theme_provider.dart';
import 'package:study_savvy_app/screens/article_improver/article_improver.dart';
import 'package:study_savvy_app/screens/files/files.dart';
import 'package:study_savvy_app/screens/home.dart';
import 'package:study_savvy_app/screens/profile/profile.dart';
import 'package:study_savvy_app/widgets/custom_navigate.dart';

void main(){
  testWidgets('Bottom-navigator test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
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
      child: const MaterialApp(
        home:HomePage()
      ),
    ));

    expect(find.byType(HomePage),findsOneWidget);
    expect(find.byType(CustomNavigate),findsOneWidget);

    await tester.tap(find.byIcon(Icons.feed_outlined));
    await tester.pump();
    // Replace for audio page
    expect(find.byType(ArticleImproverPage),findsNothing);
    expect(find.byType(FilesPage),findsNothing);
    expect(find.byType(ProfilePage),findsNothing);

    await tester.tap(find.byIcon(Icons.mode_edit_outline_outlined));
    await tester.pump();
    // Replace for audio page
    expect(find.byType(ArticleImproverPage),findsOneWidget);
    expect(find.byType(FilesPage),findsNothing);
    expect(find.byType(ProfilePage),findsNothing);

    await tester.tap(find.byIcon(Icons.access_time));
    await tester.pump();
    // Replace for audio page
    expect(find.byType(ArticleImproverPage),findsNothing);
    expect(find.byType(FilesPage),findsOneWidget);
    expect(find.byType(ProfilePage),findsNothing);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pump();
    // Replace for audio page
    expect(find.byType(ArticleImproverPage),findsNothing);
    expect(find.byType(FilesPage),findsNothing);
    expect(find.byType(ProfilePage),findsOneWidget);
  });
}