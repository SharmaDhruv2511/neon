import 'package:nextcloud/nextcloud.dart';
import 'package:nextcloud/provisioning_api.dart';
import 'package:nextcloud_test/nextcloud_test.dart';
import 'package:test/test.dart';

void main() {
  presets('server', (final preset) {
    group(
      'provisioning_api',
      () {
        late DockerContainer container;
        late NextcloudClient client;
        setUp(() async {
          container = await DockerContainer.create(preset);
          client = await TestNextcloudClient.create(
            container,
            username: 'admin',
          );
        });
        tearDown(() => container.destroy());

        group('Users', () {
          test('Get current user', () async {
            final response = await client.provisioningApi.users.getCurrentUser();
            expect(response.statusCode, 200);
            expect(() => response.headers, isA<void>());

            expect(response.body.ocs.data.id, 'admin');
            expect(response.body.ocs.data.displayName, 'admin');
            expect(response.body.ocs.data.displaynameScope, 'v2-federated');
            expect(response.body.ocs.data.language, 'en');
          });

          test('Get user by username', () async {
            final response = await client.provisioningApi.users.getUser(userId: 'user1');
            expect(response.statusCode, 200);
            expect(() => response.headers, isA<void>());

            expect(response.body.ocs.data.id, 'user1');
            expect(response.body.ocs.data.displayname, 'User One');
            expect(response.body.ocs.data.displaynameScope, null);
            expect(response.body.ocs.data.language, 'en');
          });
        });

        group('Apps', () {
          test('Get', () async {
            final response = await client.provisioningApi.apps.getApps();
            expect(response.statusCode, 200);
            expect(() => response.headers, isA<void>());
            expect(response.body.ocs.data.apps, isNotEmpty);

            for (final id in response.body.ocs.data.apps) {
              final app = await client.provisioningApi.apps.getAppInfo(app: id);
              expect(response.statusCode, 200);
              expect(() => response.headers, isA<void>());
              expect(app.body.ocs.data.id, isNotEmpty);
            }
          });
        });
      },
      retry: retryCount,
      timeout: timeout,
    );
  });
}
