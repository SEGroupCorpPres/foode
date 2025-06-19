import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_firebase_messaging.mock.dart';

void main() {
  late MockFirebaseMessaging mockFirebaseMessaging;
  setUp(() {
    mockFirebaseMessaging = MockFirebaseMessaging();
    when(() => mockFirebaseMessaging.getToken()).thenAnswer((_) async => 'dummy_fcm_token');
    when(
      () => mockFirebaseMessaging.onTokenRefresh,
    ).thenAnswer((_) => Stream.fromIterable(['new_dummy_fcm_token']));
  });

  test('should retrieve FCM token', () async {
    final token = await mockFirebaseMessaging.getToken();
    expect(token, 'dummy_fcm_token');
  });
  test('should handle token refresh', () async {
    final tokenStream = mockFirebaseMessaging.onTokenRefresh;
    final tokens = await tokenStream.toList();
    expect(tokens, ['new_dummy_fcm_token']);
  });
  test('should handle empty message streams', () async {
    final messageStream = mockFirebaseMessaging.onMessage;
    final messages = <RemoteMessage>[];
    await for (final message in messageStream) {
      messages.add(message);
      break;
    }
    expect(messages, isEmpty);
    final openedAppStream = mockFirebaseMessaging.onMessageOpenedApp;
    final openedAppMessages = <RemoteMessage>[];
    await for (final message in openedAppStream) {
      openedAppMessages.add(message);
      break;
    }
    expect(openedAppMessages, isEmpty);
  });
}
