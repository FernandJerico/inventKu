import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventku/views/screen/login/login_screen.dart';

void main() {
  group('Login Screen Test', () {
    testWidgets('Test if LoginPage widget is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    // Test text welcome section
    testWidgets('Test if text welcome is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      expect(find.text('Hello Again!'), findsOneWidget);
      expect(find.text('Welcome back, you\'ve been missed!'), findsOneWidget);
    });

    // Test the text fields
    testWidgets('Test if username, email and password text fields are rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    // Test text forgot password
    testWidgets('Test if text forgot password is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      expect(find.text('Forgot Password?'), findsOneWidget);
    });

    // Test the button
    testWidgets('Test if login button is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      expect(find.text('Login'), findsOneWidget);
    });

    // Test the not a member section
    testWidgets('Test if text not a member is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
      expect(find.text('Not a member?'), findsOneWidget);
    });
  });
}
