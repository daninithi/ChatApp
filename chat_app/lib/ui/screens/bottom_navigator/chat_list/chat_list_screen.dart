import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chat_list_viewmodel.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});
  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  // int _userCount = 0;
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return  ChangeNotifierProvider(
      create: (context) => ChatListViewmodel(DatabaseService(), currentUser!),
      child: Consumer<ChatListViewmodel>(
        // ignore: deprecated_member_use
        builder: (context, model, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
            child:  Column(
              children: [
                30.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Chats", style: h),
                ),
                20.verticalSpace,
                model.state == ViewState.loading 
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : model.chatUsers.isEmpty
                    ? const Expanded(child: Center(child: Text("No chats yet. Scan a QR code to start chatting!")))
                    : Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        itemCount: model.chatUsers.length,
                        separatorBuilder: (context, index) => 8.verticalSpace,
                        itemBuilder: (context, index) {
                          final user = model.chatUsers[index];
                          return ChatTile(
                            user: user,
                            onTap: () => Navigator.pushNamed(context, chatroom, arguments: user));
                        },
                      ),
                  ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final UserModel user;
  final void Function()? onTap;

  const ChatTile({
    super.key, this.onTap, required this.user
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      // ignore: deprecated_member_use
      tileColor: grey.withOpacity(0.12),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: CircleAvatar(
        backgroundColor: grey,
        radius: 25,
        child: Text(user.name![0].toUpperCase(), style: h2.copyWith(color: white)),
      ),
      title:  Text(user.name!),
      subtitle: Text(
        user.lastMessage != null ? user.lastMessage!["content"] : "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            user.lastMessage == null ? "" : getTime(),
            style: TextStyle(color: grey),
          ),
          10.verticalSpace,
          user.unreadCounter == 0 || user.unreadCounter == null ? SizedBox(height:15,) :  CircleAvatar(
            radius: 9.r,
            backgroundColor: Primary,
            child: Text(
              "${user.unreadCounter}",
              style: small.copyWith(color: white),
            ),
          )
        ],
      ),
    );
  }

   String getTime() {
    if (user.lastMessage == null) {
      return "";
    }

    DateTime lastMessageTime = DateTime.fromMillisecondsSinceEpoch(user.lastMessage!["timestamp"]);
    Duration difference = DateTime.now().difference(lastMessageTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inHours < 1) {
      int minutes = difference.inMinutes;
      return "$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago";
    } else if (difference.inDays < 1) {
      int hours = difference.inHours;
      return "$hours ${hours == 1 ? 'hour' : 'hours'} ago";
    } else if (difference.inDays < 7) {
      int days = difference.inDays;
      return "$days ${days == 1 ? 'day' : 'days'} ago";
    } else {
      return "${lastMessageTime.day}/${lastMessageTime.month}/${lastMessageTime.year}";
    }
  }
}
