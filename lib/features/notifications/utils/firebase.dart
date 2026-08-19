import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/features/notifications/models/notification_model.dart';
import 'package:maintly_app/features/notifications/utils/on_notification_click.dart';
import 'package:maintly_app/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  pr('Background message: ${message.messageId}', 'FCM');
  pr(message.notification?.title, "FCM TITLE");
  pr(message.notification?.body, "FCM BODY");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

Future<void> initializeNotifications() async {
  try {
    await _ensureAndroidNotificationPermission();

    if (Platform.isIOS) {
      await requestPermissions();
    }
    setupForegroundMessageHandler();
    setupInteractionHandlers();

    if (Platform.isAndroid) {
      await _createAndroidNotificationChannel();
    }

    await getFcmToken();
  } catch (e, st) {
    pr('Error initializing notifications: $e\n$st', 'FCM');
  }
}

Future<void> requestPermissions() async {
  try {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    pr('FCM permission (iOS): ${settings.authorizationStatus}', 'FCM');

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  } catch (e, st) {
    pr('Error requesting FCM permissions (iOS): $e\n$st', 'FCM');
  }
}

Future<void> _ensureAndroidNotificationPermission() async {
  if (!Platform.isAndroid) return;

  try {
    final status = await Permission.notification.status;
    pr('Android notification permission status: $status', 'FCM');

    if (status.isDenied) {
      final result = await Permission.notification.request();
      pr('Android notification permission requested: $result', 'FCM');
    }

    if (status.isPermanentlyDenied) {
      pr('Notification permission permanently denied', 'FCM');
    }
  } catch (e, st) {
    pr('Error checking/requesting Android notification permission: $e\n$st', 'FCM');
  }
}

Future<void> _createAndroidNotificationChannel() async {
  try {
    final androidImpl = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl != null) {
      await androidImpl.createNotificationChannel(channel);
      pr('Android notification channel created: ${channel.id}', 'FCM');
    } else {
      pr('Android implementation for local notifications not available', 'FCM');
    }
  } catch (e, st) {
    pr('Error creating Android notification channel: $e\n$st', 'FCM');
  }
}

void setupInteractionHandlers() {
  FirebaseMessaging.onMessageOpenedApp.listen(onMessageOpenApp);

  FirebaseMessaging.instance.getInitialMessage().then(getInitialMessageFromTerminatedState);

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    pr('FCM token refreshed: $newToken', 'FCM');
  });
}

Future<String?> getFcmToken() async {
  try {
    final token = await FirebaseMessaging.instance.getToken();
    pr('FCM token: $token', 'FCM');
    return token;
  } catch (e, st) {
    pr('Error getting FCM token: $e\n$st', 'FCM');
    return null;
  }
}

void setupForegroundMessageHandler() {
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      pr(
        'Foreground message received: ${message.notification?.title} / ${message.notification?.body}',
        'FCM',
      );
      pr(message.data, 'FCM-data setupForegroundMessageHandler');

      final notification = message.notification;

      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: const DarwinNotificationDetails(),
      );
      final payloadJson = jsonEncode(message.data);
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: notificationDetails,
          payload: payloadJson,
        );

        return;
      }
    },
    onError: (error) {
      pr('Error in onMessage listener: $error', 'FCM');
    },
  );
}

//! Handle taps on local notifications (main.dart init)
void onDidReceiveLocalNotificationResponse(NotificationResponse response) {
  final payload = response.payload;
  pr('Local notification tapped. payload: $payload', 'FCM');
  try {
    if (payload != null && payload.isNotEmpty) {
      final model = NotificationModel.fromJson(jsonDecode(payload));
      onNotificationClick(model);
    }
  } catch (e, st) {
    pr('Error parsing local notification payload: $e\n$st', 'FCM');
  }
}

//! Background (app in background → user taps system notification)
Future<void> onMessageOpenApp(RemoteMessage message) async {
  pr('Opened from notification: ${message.messageId}', 'FCM');
  pr(message.data, 'FCM-data setupInteractionHandlers');

  try {
    if (message.data.isEmpty) {
      return;
    }

    final model = NotificationModel.fromJson(message.data);

    await onNotificationClick(model);
  } catch (e, st) {
    pr('Error handling onMessageOpenedApp: $e\n$st', 'FCM');
  }
}

//! Terminated (app launched from terminated state)
void getInitialMessageFromTerminatedState(RemoteMessage? message) {
  if (message != null) {
    pr('App opened from terminated state by notification: ${message.messageId}', 'FCM');
    try {
      final map = message.data;
      if (map.isNotEmpty) {
        final model = NotificationModel.fromJson(map);
        Future.delayed(Duration(seconds: 1), () => onNotificationClick(model));
      }
    } catch (e, st) {
      pr('Error handling initial message: $e\n$st', 'FCM');
    }
  }
}

Future notificationsInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
    // todo: onDidReceiveLocalNotification for older iOS if needed.
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveLocalNotificationResponse,
  );
  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  //   onDidReceiveNotificationResponse: onDidReceiveLocalNotificationResponse,
  // );
  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
