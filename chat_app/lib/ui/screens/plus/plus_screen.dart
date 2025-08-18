import 'package:chat_app/core/constants/strings.dart';
import 'package:flutter/material.dart';

class PlusScreen extends StatelessWidget {
  const PlusScreen({super.key});

  final List<Map<String, String>> contacts = const [
    {'name': 'John Doe', 'status': 'Available'},
    {'name': 'Sarah Wilson', 'status': 'At work'},
    {'name': 'Mike Johnson', 'status': 'Busy'},
    {'name': 'Emily Davis', 'status': 'Chilling'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      

      body: ListView.builder(
        itemCount: contacts.length + 2, // +1 for "New Contact", +1 for "Saved Contacts" label
        itemBuilder: (context, index) {
          if (index == 0) {
            // New Contact button
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, qrSystem); // <-- Navigate to QR system screen
              },
              leading: const Icon(Icons.person_add, color: Colors.black),
              title: const Text(
                'New Contact',
                style: TextStyle(color: Colors.black),
              ),
            );
          }
            // ...existing code...
           else if (index == 1) {
            // "Saved Contacts" header
            return const Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: Text(
                'Saved Contacts',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final contact = contacts[index - 2];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(contact['name'] ?? '', style: const TextStyle(color: Colors.black)),
            subtitle: Text(contact['status'] ?? '', style: const TextStyle(color: Colors.black54)),
            onTap: () {
              // TODO: Implement contact tap functionality
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}