import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_savvy_app/widgets/failure.dart';

void main(){
  testWidgets('Failure-widget test', (WidgetTester tester) async{
    const String errorString="Error test";
    await tester.pumpWidget(const MaterialApp(home:Failure(error:errorString)));

    expect(find.byType(Failure), findsOneWidget);
    expect(find.text(errorString), findsOneWidget);
  });
}