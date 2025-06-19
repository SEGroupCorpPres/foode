import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationServices{
  Future<void> initialize();
  Future<String?> getFCMToken();
  Stream<RemoteMessage> get onMessage;
  Stream<RemoteMessage> get onMessageOpenedApp;
}