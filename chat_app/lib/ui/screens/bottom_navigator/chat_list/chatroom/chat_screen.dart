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
                _BuildHeader(context, name: "John Doe"),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(10),
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


