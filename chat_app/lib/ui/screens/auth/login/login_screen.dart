import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/ui/widgets/button_widget.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            40.verticalSpace,
            Text("Login", style: h),
            5.verticalSpace,
            const Text("Login your account"),
            30.verticalSpace,
            CustomTextField(
              hintText: "Enter email",
              onChanged: (p0) {},
            ),
            20.verticalSpace,
            CustomTextField(
              hintText: "Enter password",
              onChanged: (p0) {},
            ), 
            30.verticalSpace,
            CustomButton(
              onPressed: () {},
              text: "Log In", 
            ),
            20.verticalSpace,
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Don't have an account?",style: body.copyWith(color: grey)), 
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, signup);
              },
              child: Text("Sign Up", style: body.copyWith(fontWeight: FontWeight.bold)),
            )],)

          ],
        ),
      ),
    );
  }
}
