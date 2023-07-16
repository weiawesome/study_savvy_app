import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_savvy_app/widgets/success.dart';

void main(){
  testWidgets('Success-widget test', (WidgetTester tester) async{
    const String successString="Success test";
    await tester.pumpWidget(const MaterialApp(home:Success(message: successString,)));

    expect(find.byType(Success), findsOneWidget);
    expect(find.text(successString), findsOneWidget);
  });
}