
import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, this.focusNode, this.hintText, this.onChanged
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focusNode,
     decoration: InputDecoration(
       filled: true,
       // ignore: deprecated_member_use
       fillColor: grey.withOpacity(0.2),
       hintText: hintText,
        hintStyle: body.copyWith(color: grey),
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(10.r),
         borderSide: BorderSide.none,
       ),
     ),
                );
  }
}
