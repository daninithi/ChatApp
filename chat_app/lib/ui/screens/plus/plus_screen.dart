import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlusScreen extends StatelessWidget {
  const PlusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('contacts')
                  .doc(currentUser.uid)
                  .collection('userContacts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final contacts = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: contacts.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, qrSystem);
                        },
                        leading: const Icon(
                          Icons.person_add,
                          color: Colors.black,
                        ),
                        title: const Text(
                          'New Contact',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else if (index == 1) {
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
                    final contact =
                        contacts[index - 2].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        contact['name'] ?? '',
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        contact['uid'] ?? '',
                        style: TextStyle(color: Colors.black54),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      onLongPress: () async {
                        final contactId = contacts[index - 2].id;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Contact'),
                            content: const Text(
                              'Do you want to remove this contact?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('contacts')
                                      .doc(currentUser.uid)
                                      .collection('userContacts')
                                      .doc(contactId)
                                      .delete();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Contact deleted!'),
                                    ),
                                  );
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
