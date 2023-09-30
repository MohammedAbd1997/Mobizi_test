import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationHelper {
  NotificationHelper._();

  static NotificationHelper notificationHelper = NotificationHelper._();

  final String appId = '64229382-d4e4-4b31-91b4-9ad75ac9011b';

  final String restApiKey = 'YWRjOGFhYzEtMmM5Ni00ZDk2LWFjYTgtODg1OGVhMDRlYWNl';

  final String apiUrl = 'https://onesignal.com/api/v1/notifications';

  initNotification() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(appId);

    OneSignal.Notifications.requestPermission(true);


  }

  /// send notification via onesignal api
  Future<void> sendPushNotification(String Message) async {
    final Map<String, dynamic> payload = {
      'app_id': appId,
      "headings": {"en": "Result exam"},
      'contents': {'en': '${Message}'},
      'include_player_ids': ['${OneSignal.User.pushSubscription.id}'],
      "priority": 2,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $restApiKey',
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print('Push notification sent successfully');
    } else {
      print('Failed to send push notification');
    }
  }
}
