import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chatroom/chat_widgets.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                _BuildHeader(name: "John Doe"),
                Expanded(
                  child: ListView.separated(
                    itemCount: 5,
                    separatorBuilder: (context, index) => 10.verticalSpace,
                    itemBuilder: (context, index) =>ChatBubble(
                      isCurrentUser: false,
                    ),
                   
                  ),
                ),
              ],
             ),
            ),
          ),
          BottomFeild(
            onTap: () {},
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row _BuildHeader({String name =""}) {
    return Row(
          children: [
          Container(
            padding: const EdgeInsets.only(left: 10,  top: 6, bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              // ignore: deprecated_member_use
              color: grey.withOpacity(0.15),
            ), 
            child: const Icon(Icons.arrow_back_ios),
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

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, this.isCurrentUser = true
  });

  final bool isCurrentUser;


  @override
  Widget build(BuildContext context) {
    final borderRadius = isCurrentUser? BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          ):
          BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          );
    final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft; 
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1.sw * 0.75, minWidth: 50.w),
        padding: const EdgeInsets.all(10),
        // ignore: deprecated_member_use
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: isCurrentUser ? Primary : grey.withOpacity(0.2),
          borderRadius: borderRadius
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              "Hello, how are you?",
              style: body.copyWith(
                color: isCurrentUser ? white : null,
              ),
            ),
            5.verticalSpace,
           Text(
              "08.00pm",
              style: small.copyWith(
                color: isCurrentUser? white: null,
              ),
            )
          ],
        ),

      ),
    );
  }
}

