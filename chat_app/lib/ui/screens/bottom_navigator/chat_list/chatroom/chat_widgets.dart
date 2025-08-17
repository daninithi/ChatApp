import 'package:chat_app/core/constants/colors.dart';
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
            radius: 25.r,
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
