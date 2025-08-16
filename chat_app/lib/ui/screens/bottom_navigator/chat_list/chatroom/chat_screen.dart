import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
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
              ],
             ),
            ),
          ),
          Container(
            // ignore: deprecated_member_use
            color: grey.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 20.h),
            child:  Row(
              children: [
               CircleAvatar(
                radius: 25.r,
                backgroundColor: white,
                child: Icon(Icons.add),
              ),

              10.horizontalSpace,
              const Expanded(
                child: 
                CustomTextField(
                  isChatText: true,
                ))
            ],
           ),
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
