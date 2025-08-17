import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomFeild extends StatelessWidget {
  const BottomFeild({
    super.key, this.onTap, this.onChanged
  });

final void Function()? onTap;
final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: deprecated_member_use
      color: grey.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 20.h),
      child:  Row(
        children: [
         InkWell(
          onTap: onTap,
           child: CircleAvatar(
            radius: 20.r,
            backgroundColor: white,
            child: Icon(Icons.add),
                         ),
         ),
    
        10.horizontalSpace,
        Expanded(
          child: 
          CustomTextField(
            isChatText: true,
            hintText: "Type a message",
            onChanged: onChanged,
          ),
        )
      ],
     ),
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
              "Hello, how are you ?",
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
