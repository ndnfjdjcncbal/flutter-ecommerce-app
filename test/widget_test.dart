import 'package:ecommerce/view/bottom_navigation/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('settings page shows required options', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: myprofile()));

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Change Password'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });
}
