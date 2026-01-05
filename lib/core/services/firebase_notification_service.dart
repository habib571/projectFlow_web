import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

// This MUST be a top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Background message received: ${message.messageId}");
  log("Notification: ${message.notification?.title}");
  log("Data: ${message.data}");
}

class FirebaseNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Stream<RemoteMessage> get onMessageStream => FirebaseMessaging.onMessage;

  Future<String?> initialize() async {
    // Request permission first
    await _requestPermission();

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Set up foreground message handler
    _setupForegroundHandler();

    // Get token
    final token = await getToken();

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      log("Token refreshed: $newToken");
      // TODO: Send new token to your backend
    });

    return token;
  }

  void _setupForegroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Foreground message received!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Notification Title: ${message.notification!.title}');
        log('Notification Body: ${message.notification!.body}');

        // For web, you might want to show a custom notification here
        if (kIsWeb) {
          // The browser will handle it automatically if service worker is set up
          log('Web notification will be handled by browser');
        }
      }
    });
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    log('Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  Future<String?> getToken() async {
    try {
      String? token;
      if (kIsWeb) {
        // IMPORTANT: Add your VAPID key here
        // Get it from Firebase Console -> Project Settings -> Cloud Messaging -> Web Push certificates
        token = await _firebaseMessaging.getToken(
            vapidKey: "BApRNzWX6YAnK1wsTO9G_jcwEXZLopV58A4gKkYRSljbcqLi7O4VhzcX4By33XeQShPp0_K0Y8rySOIb8xCjUzY"  // REPLACE THIS!
        );
      } else {
        token = await _firebaseMessaging.getToken();
      }
      log("FCM Token: $token");
      return token;
    } catch (e) {
      log("Error getting FCM token: $e");
      return null;
    }
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
    log("Token deleted");
  }
}