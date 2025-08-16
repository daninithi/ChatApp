import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/ui/widgets/button_widget.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.verticalSpace,
            Text("create your account", style: h),
            5.verticalSpace,
            const Text("Please provide your details"),
            24.verticalSpace,
            CustomTextField(
              hintText: "Enter your name",
              onChanged: (p0) {},
            ),
            20.verticalSpace,
            CustomTextField(
              hintText: "Enter your email",
              onChanged: (p0) {},
            ),
            20.verticalSpace,
            CustomTextField(
              hintText: "Enter your password",
              onChanged: (p0) {},
            ),
            20.verticalSpace,
            CustomTextField(
              hintText: "Confirm your password",
              onChanged: (p0) {},
            ),
            30.verticalSpace,
            CustomButton(
              onPressed: () {},
              text: "Sign Up",
            ),
            20.verticalSpace,
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("already have an account?",style: body.copyWith(color: grey)), 
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, login);
              },
              child: Text("Log in", style: body.copyWith(fontWeight: FontWeight.bold)),
            )],)

          ],
        ),
      ),
    );
  }
}

