import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_savvy_app/widgets/loading.dart';

void main(){
  testWidgets('Loading-widget test', (WidgetTester tester) async{
    await tester.pumpWidget(const MaterialApp(home:Loading()));

    expect(find.byType(Loading), findsOneWidget);
  });
}