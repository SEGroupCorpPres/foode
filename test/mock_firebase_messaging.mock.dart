import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {
  Stream<RemoteMessage> get onMessage => Stream<RemoteMessage>.empty();
  Stream<RemoteMessage> get onMessageOpenedApp => Stream<RemoteMessage>.empty();
}