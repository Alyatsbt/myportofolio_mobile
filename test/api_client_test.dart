import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

void main() {
  const projectJson = {
    'id': 'a18a2311-0463-4f79-8026-bfc2339e73a4',
    'title': 'Portfolio',
    'subtitle': 'Mobile portfolio',
    'description': 'A sample app',
    'thumbnail': '/static/img/project.png',
    'project_url': 'https://example.com',
    'created_at': '2026-11-25T11:00:00Z',
    'star_count': 2,
    'is_starred': false,
    'starred_by_names': '',
  };

  group('Project serialization', () {
    test('maps snake case fields and omits server-managed id', () {
      final project = Project.fromJson(projectJson);
      expect(project.id, 'a18a2311-0463-4f79-8026-bfc2339e73a4');
      expect(project.subtitle, 'Mobile portfolio');
      expect(project.thumbnail, '/static/img/project.png');
      expect(project.starCount, 2);
      expect(project.toJson(), {
        'title': 'Portfolio',
        'subtitle': 'Mobile portfolio',
        'description': 'A sample app',
        'thumbnail': '/static/img/project.png',
        'project_url': 'https://example.com',
      });
    });

    test('uses empty defaults for omitted optional URLs', () {
      final project = Project.fromJson({
        'title': 'T',
        'subtitle': 'S',
        'description': 'D',
      });
      expect(project.projectUrl, isNull);
      expect(project.thumbnail, isNull);
      expect(project.isStarred, isFalse);
    });
  });

  group('ApiClient', () {
    test('gets public project array and supports empty list', () async {
      var requests = 0;
      final client = ApiClient(
        baseUrl: 'http://localhost:8000',
        client: MockClient((request) async {
          requests++;
          expect(request.method, 'GET');
          expect(request.url.path, '/api/v1/projects/');
          expect(request.headers['Accept'], 'application/json');
          return http.Response(
            requests == 1 ? jsonEncode([projectJson]) : '[]',
            200,
          );
        }),
      );
      addTearDown(client.close);
      expect((await client.getProjects()).single.title, 'Portfolio');
      expect(await client.getProjects(), isEmpty);
    });

    test('posts authenticated project with JSON payload', () async {
      final client = ApiClient(
        client: MockClient((request) async {
          expect(request.method, 'POST');
          expect(request.headers['Authorization'], 'Token secret');
          expect(
            request.headers['Content-Type'],
            'application/json; charset=UTF-8',
          );
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body.containsKey('id'), isFalse);
          expect(body['title'], 'Portfolio');
          expect(body['subtitle'], 'Subtitle');
          return http.Response(jsonEncode(projectJson), 201);
        }),
      );
      addTearDown(client.close);
      final created = await client.createProject(
        const Project(
          title: 'Portfolio',
          subtitle: 'Subtitle',
          description: 'A sample app',
        ),
        token: 'secret',
      );
      expect(created.id, 'a18a2311-0463-4f79-8026-bfc2339e73a4');
    });

    test('obtains token and logs out on HTTP 204', () async {
      var count = 0;
      final client = ApiClient(
        client: MockClient((request) async {
          count++;
          if (count == 1) {
            expect(request.url.path, '/api/v1/auth/token/');
            expect(jsonDecode(request.body), {
              'username': 'student',
              'password': 'dummy-password',
            });
            return http.Response('{"token":"dummy-token"}', 200);
          }
          expect(request.url.path, '/api/v1/auth/logout/');
          expect(request.headers['Authorization'], 'Token dummy-token');
          return http.Response('', 204);
        }),
      );
      addTearDown(client.close);
      final token = await client.obtainToken('student', 'dummy-password');
      expect(token, 'dummy-token');
      await client.logout(token: token);
    });

    test('maps HTTP errors to safe ApiException', () async {
      final client = ApiClient(
        client: MockClient(
          (_) async => http.Response('<html>secret</html>', 403),
        ),
      );
      addTearDown(client.close);
      await expectLater(
        client.getProjects(),
        throwsA(
          isA<ApiException>()
              .having((error) => error.statusCode, 'statusCode', 403)
              .having((error) => error.message, 'message', contains('izin')),
        ),
      );
    });
  });

  test('AuthState clears local token even if server logout fails', () async {
    final api = ApiClient(
      client: MockClient((_) async => http.Response('', 503)),
    );
    addTearDown(api.close);
    final state = AuthState(api, initialToken: 'expired');
    expect(state.isLoggedIn, isTrue);
    await expectLater(state.logout(), throwsA(isA<ApiException>()));
    expect(state.token, isNull);
    expect(state.isLoggedIn, isFalse);
  });
}
