import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';
import 'notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await FirebaseService().configureFirebaseMessaging(); // Configure Firebase Messaging
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  MyApp() {
    // Configure Firebase Messaging
    _firebaseService.configureFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Messaging Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: NotificationsPage(), // Set NotificationsPage as the home screen
    );
  }
}
