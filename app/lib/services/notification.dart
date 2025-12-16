import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iism_2025/services/api_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NotificationService {
  final _messaging = FirebaseMessaging.instance;
  final ApiService _apiService;

  NotificationService._(this._apiService);

  static Future<NotificationService> init(ApiService api) async {
    final instance = NotificationService._(api);
    final messagingSettings = await instance._messaging.requestPermission(
      announcement: true,
    );
    if (messagingSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      final fcmToken = await instance._messaging.getToken();
      await api.dio.post("/api/save-fcm-token", data: {"token": fcmToken});
    }
    instance._messaging.onTokenRefresh.listen((token) async {
      await api.dio.post("/api/save-fcm-token", data: {"token": token});
    });

    final initMessage = await instance._messaging.getInitialMessage();
    if (initMessage != null) {
      if (initMessage.data["open_url"] != null) {
        launchUrlString(initMessage.data["open_url"]);
      }
    }
    instance._messaging.setForegroundNotificationPresentationOptions(
      alert: true,
    );
    FirebaseMessaging.onMessage.listen((msg) {
      if (msg.data["open_url"] != null) {
        launchUrlString(msg.data["open_url"]);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      if (msg.data["open_url"] != null) {
        launchUrlString(msg.data["open_url"]);
      }
    });

    return instance;
  }
}
