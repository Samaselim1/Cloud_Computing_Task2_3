import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  List<Map<String, String>> notifications = []; // List to hold notifications in memory

  // Initialize Firebase Messaging
  Future<void> configureFirebaseMessaging() async {
    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    // Get the device token for FCM
    String? token = await _messaging.getToken();
    print("Device Token: $token");

    // Listen to messages in the foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle messages when the app is opened by tapping a notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedAppMessage);
  }

  // Handle the background message
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(); // Ensure Firebase is initialized in background
    // Optionally, you can store this message in shared_preferences or another local storage method
    FirebaseService firebaseService = FirebaseService(); // Create an instance of FirebaseService
    firebaseService._saveMessageToLocal(message);   }

  // Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    print('Received message in foreground: ${message.notification?.title}');
    _saveMessageToLocal(message); // Save the message locally
  }

  // Handle when the app is opened from a notification click
  void _handleOpenedAppMessage(RemoteMessage message) {
    print('App opened due to notification click: ${message.notification?.title}');
  }

  // Save the message to a local list
  void _saveMessageToLocal(RemoteMessage message) {
    // Save the message locally, here I am just adding it to an in-memory list
    notifications.add({
      'title': message.notification?.title ?? 'No Title',
      'body': message.notification?.body ?? 'No Body',
      'timestamp': DateTime.now().toString(),
    });
  }
}
