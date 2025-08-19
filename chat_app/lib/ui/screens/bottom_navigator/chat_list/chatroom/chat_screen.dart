import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/extension/widget_extension.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/chat_service.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chatroom/chat_viewmodel.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chatroom/chat_widgets.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiver});
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) => ChatViewmodel(ChatService(), currentUser!, receiver),
      child: Consumer<ChatViewmodel>(
        builder: (context, model, _) {
          // Set up callback to show contact request dialog
          model.onContactRequestReceived = (request, requestId) {
            if (request['receiverUid'] == currentUser!.uid) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Contact Request'),
                    content: Text(
                      'User ${request['senderName']} wants to add you as a contact.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          // Reject: update request status
                          await DatabaseService().updateContactRequestStatus(
                            requestId,
                            'rejected',
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text('Reject'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Accept: update request status and add contact for both users
                          await DatabaseService().updateContactRequestStatus(
                            requestId,
                            'accepted',
                          );
                          // Add sender to receiver's contacts
                          await DatabaseService()
                              .saveContact(currentUser.uid!, {
                                'uid': request['senderUid'],
                                'name': request['senderName'],
                              });
                          // Add receiver to sender's contacts
                          await DatabaseService().saveContact(
                            request['senderUid'],
                            {
                              'uid': currentUser.uid!,
                              'name': currentUser.name ?? '',
                            },
                          );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Contact added!')),
                          );
                        },
                        child: const Text('Accept'),
                      ),
                    ],
                  );
                },
              );
            }
          };
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.sw * 0.05,
                      vertical: 25.h,
                    ),
                    child: Column(
                      children: [
                        35.verticalSpace,
                        _BuildHeader(context, name: receiver.name!),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemCount: model.messages.length,
                            separatorBuilder: (context, index) =>
                                10.verticalSpace,
                            itemBuilder: (context, index) {
                              final message = model.messages[index];
                              return ChatBubble(
                                isCurrentUser:
                                    message.senderId == currentUser!.uid,
                                message: message,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BottomFeild(
                  controller: model.controller,
                  onTap: () async {
                    try {
                      await model.saveMessage();
                    } catch (e) {
                      context.showSnackBar(e.toString());
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _BuildHeader(BuildContext context, {String name = ""}) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              // ignore: deprecated_member_use
              color: grey.withOpacity(0.15),
            ),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        15.verticalSpace,
        Text(name, style: h.copyWith(fontSize: 20.sp)),
        const Spacer(),
        // Show tick with person icon if already contacts, else show person+ icon
        FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('contacts')
              .doc(Provider.of<UserProvider>(context, listen: false).user!.uid)
              .collection('userContacts')
              .doc(receiver.uid)
              .get(),
          builder: (context, snapshot) {
            final isContact = snapshot.data?.exists ?? false;
            if (isContact) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: grey.withOpacity(0.15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.person, size: 28),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Contact Request'),
                        content: const Text(
                          'Do you want to send a contact request to the receiver?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final currentUser = Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).user;
                              final receiver = this.receiver;
                              await DatabaseService().sendContactRequest(
                                senderUid: currentUser!.uid!,
                                senderName: currentUser.name ?? '',
                                receiverUid: receiver.uid!,
                              );
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Contact request sent!'),
                                ),
                              );
                            },
                            child: const Text('Send'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: grey.withOpacity(0.15),
                  ),
                  child: const Icon(Icons.person_add_alt_1),
                ),
              );
            }
          },
        ),
        // 3-dot icon
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: grey.withOpacity(0.15),
          ),
          child: const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
