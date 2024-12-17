import 'package:flutter/material.dart';
import 'firebase_service.dart';

class NotificationsPage extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications History'),
      ),
      body: StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (_) => _firebaseService.notifications),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications received yet.'));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final title = notification['title'] ?? 'No Title';
              final body = notification['body'] ?? 'No Body';
              final timestamp = notification['timestamp'] ?? 'No Timestamp';

              return ListTile(
                title: Text(title),
                subtitle: Text(body),
                trailing: Text(timestamp),
                onTap: () {
                  // Optionally handle tap to show notification details
                  print("Tapped on notification: $title");
                },
              );
            },
          );
        },
      ),
    );
  }
}
