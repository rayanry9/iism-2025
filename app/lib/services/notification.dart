import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iism_2025/services/api_service.dart';

class NotificationService {
  static final _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    final messagingSettings = await _messaging.requestPermission(
      announcement: true,
    );
    if (messagingSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      final fcmToken = await _messaging.getToken();
      await dio.post("/api/save-fcm-token", data: {"token": fcmToken});
    }
    _messaging.onTokenRefresh.listen((token) async {
      await dio.post("/api/save-fcm-token", data: {"token": token});
    });
  }
}
