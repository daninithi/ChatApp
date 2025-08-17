import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
// import 'package:chat_app/core/enums/enums.dart';
// import 'package:chat_app/core/extension/widget_extension.dart';
// import 'package:chat_app/core/services/auth_service.dart';
// import 'package:chat_app/core/services/database_service.dart';
// import 'package:chat_app/ui/screens/auth/signup/signup_viewmodel.dart';
// import 'package:chat_app/ui/widgets/button_widget.dart';
// import 'package:chat_app/ui/widgets/textfield_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';

// class EmailVerify extends StatelessWidget {
//   const EmailVerify({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<SignUpViewModel>(
//       create: (context) => SignUpViewModel(AuthService(), DatabaseService()),
//       child: Consumer<SignUpViewModel>(
//         builder: (context, modal, _) {
//           return Scaffold(
//             body: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   30.verticalSpace,
//                   Text("create your account", style: h),
//                   5.verticalSpace,
//                   const Text("Please verify your email"),
//                   20.verticalSpace,
//                   CustomTextField(
//                     hintText: "Enter your email",
//                     onChanged: modal.setEmail,
//                   ),
//                   30.verticalSpace,
//                   CustomButton(
//                     loading: modal.state == ViewState.loading,
//                     onPressed: modal.state == ViewState.loading
//                       ? null
//                       : () async{
//                       try {
//                         await modal.sendVerificationOtp();
//                         context.showSnackBar("Verification email sent. Please check your inbox.");
//                         // Navigate to OTP verification screen
//                         Navigator.pushNamed(context, otpverify);
//                       } 
//                       on FirebaseAuthException catch (e) {
//                         context.showSnackBar(e.toString());
//                       } catch (e) {
//                         context.showSnackBar(e.toString());
//                       }
//                     },
//                     text: "Verify Email",
//                   ),
//                   20.verticalSpace,
//                   Row(mainAxisAlignment: MainAxisAlignment.center,
//                   children: [Text("already have an account?",style: body.copyWith(color: grey)), 
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(context, login);
//                     },
//                     child: Text("Log in", style: body.copyWith(fontWeight: FontWeight.bold)),
//                   )],)
          
//                 ],
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:chat_app/core/services/email_service.dart';
import 'package:chat_app/ui/screens/auth/signup/signup_screen.dart';

class EmailVerifyScreen extends StatefulWidget {
  final String email;
  const EmailVerifyScreen({required this.email});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final _otpController = TextEditingController();
  bool _loading = false;
  String? _error;

  void _verifyOtp() {
    setState(() => _loading = true);
    final enteredOtp = _otpController.text.trim();
    if (enteredOtp == EmailService.lastOtp) {
      setState(() => _loading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SignUpScreen(email: widget.email),
        ),
      );
    } else {
      setState(() {
        _loading = false;
        _error = 'Invalid OTP';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the OTP sent to ${widget.email}'),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
            ),
            if (_error != null) ...[
              SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Colors.red)),
            ],
            SizedBox(height: 24),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verifyOtp,
                    child: Text('Verify'),
                  ),
          ],
        ),
      ),
    );
  }
}