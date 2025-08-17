import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.isSearch = false,
    this.isChatText = false,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isSearch;
  final bool isChatText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isChatText ? 35.h : null,
      child: TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: isChatText ? EdgeInsets.symmetric(horizontal: 12.w) : null,
          filled: true,
          // ignore: deprecated_member_use
          fillColor: isChatText ? white : grey.withOpacity(0.12),
          hintText: hintText,
          hintStyle: body.copyWith(color: grey),
          suffixIcon: isSearch ? Container(
            height: 55,
            width: 55,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(searchIcon),
          ) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isChatText ? 25.r : 12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
