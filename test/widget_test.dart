import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('homepage renders portfolio identity and public actions', (
    tester,
  ) async {
    final api = ApiClient(
      client: MockClient((_) async => throw StateError('Unexpected request')),
    );
    addTearDown(api.close);

    await tester.pumpWidget(MyApp(apiClient: api));

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Alya Tsabita Imani'), findsOneWidget);
    expect(find.text('View Projects'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Logout'), findsNothing);
  });

  testWidgets('Add Project requires login and opens form after login', (
    tester,
  ) async {
    final api = ApiClient(
      client: MockClient((request) async {
        expect(request.url.path, '/api/v1/auth/token/');
        return http.Response(jsonEncode({'token': 'test-token'}), 200);
      }),
    );
    addTearDown(api.close);

    await tester.pumpWidget(MyApp(apiClient: api));
    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Title'), findsNothing);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('MyPortfolio'), findsOneWidget);

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'test-owner');
    await tester.enterText(find.byType(TextFormField).at(1), 'dummy-password');
    await tester.tap(find.widgetWithText(FilledButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Add Project Form'), findsOneWidget);
    expect(find.text('Subtitle'), findsOneWidget);
  });
}
