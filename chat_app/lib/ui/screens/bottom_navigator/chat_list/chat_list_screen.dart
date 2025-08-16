import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
      child:  Column(
        children: [
          30.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: Text("chats", style: h),
          ),
          20.verticalSpace,
          const CustomTextField(
            isSearch: true,
            hintText: "search here",
          ),
          10.verticalSpace,
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              itemCount: 10,
              separatorBuilder: (context, index) => 8.verticalSpace,
              itemBuilder: (context, index) =>  ChatTile(onTap: () => Navigator.pushNamed(context, chatroom)),
            ),
          )
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key, this.onTap,
  });

  final void Function()? onTap;

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
        child: Text("S"),
      ),
      title: const Text("data"),
      subtitle: const Text(
        "last message",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "15 min ago",
            style: TextStyle(color: grey),
          ),
          10.verticalSpace,
          CircleAvatar(
            radius: 9.r,
            backgroundColor: Primary,
            child: Text(
              "1",
              style: small.copyWith(color: white),
            ),
          )
        ],
      ),
    );
  }
}