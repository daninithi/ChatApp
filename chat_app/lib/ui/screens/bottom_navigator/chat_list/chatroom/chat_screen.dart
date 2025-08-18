import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/extension/widget_extension.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/chat_service.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chatroom/chat_viewmodel.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chatroom/chat_widgets.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.receiver});
  final UserModel receiver;  

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  // Add a reference to the ChatService
  final ChatService _chatService = ChatService();
  late final UserModel _currentUser;

  @override
  void initState() {
    super.initState();
    // Use `Provider.of` with `listen: false` to get the current user
    _currentUser = Provider.of<UserProvider>(context, listen: false).user!;

    // Call the method to reset the unread counter.
    // The method you defined needs to be part of the `ChatService` class
    // outside of the `updateLastMessage` method.
    _chatService.resetUnreadCounter(_currentUser.uid!);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return ChangeNotifierProvider(
      create: (context) => ChatViewmodel(ChatService(), currentUser!, widget.receiver),
      child: Consumer<ChatViewmodel>(
        builder: (context, model, _) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.sw *0.05, vertical: 25.h),
                    child: Column(
                      children: [
                        35.verticalSpace,
                      _BuildHeader(context, name: widget.receiver.name!),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemCount: model.messages.length,
                          separatorBuilder: (context, index) => 10.verticalSpace,
                          itemBuilder: (context, index)  { 
                            final message = model.messages[index];
                            return ChatBubble(
                            isCurrentUser: message.senderId == currentUser!.uid,
                            message: message,
                          );},
                        ),
                      )
                    ],
                   ),
                  ),
                ),
                BottomFeild(
                  controller: model.controller,
                  onTap: () async{
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
        }
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _BuildHeader(BuildContext context, {String name =""}) {
    return Row(
          children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.only(left: 10,  top: 6, bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                // ignore: deprecated_member_use
                color: grey.withOpacity(0.15),
              ), 
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          15.verticalSpace,
          Text(
            name,
            style: h.copyWith(
              fontSize: 20.sp,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              // ignore: deprecated_member_use
              color: grey.withOpacity(0.15),
            ),
            child: const Icon(Icons.more_vert),
          ),

        ],

        );
  }
}


