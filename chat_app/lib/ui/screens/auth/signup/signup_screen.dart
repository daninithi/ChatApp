import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/extension/widget_extension.dart';
import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/screens/auth/signup/signup_viewmodel.dart';
import 'package:chat_app/ui/widgets/button_widget.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(AuthService(), DatabaseService()),
      child: Consumer<SignUpViewModel>(
        builder: (context, modal, _) {
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
                    onChanged: modal.setName,
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    hintText: "Enter your email",
                    onChanged: modal.setEmail,
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    hintText: "Enter your password",
                    onChanged: modal.setPassword,
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    hintText: "Confirm your password",
                    onChanged: modal.setConfirmPassword,
                  ),
                  30.verticalSpace,
                  CustomButton(
                    loading: modal.state == ViewState.loading,
                    onPressed: modal.state == ViewState.loading
                      ? null
                      : () async{
                      try {
                        await modal.signup();
                        context.showSnackBar("Sign up successful");
                        Navigator.pop(context);
                      } 
                      on FirebaseAuthException catch (e) {
                        context.showSnackBar(e.toString());
                      } catch (e) {
                        context.showSnackBar(e.toString());
                      }
                    },
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
      ),
    );
  }
}