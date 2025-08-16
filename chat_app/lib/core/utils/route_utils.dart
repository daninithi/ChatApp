import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/ui/screens/auth/signup/signup_screen.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chatroom/chat_screen.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/screens/splash/splash_screen.dart';





class RouteUtils {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
       case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen()); 
        //auth
       case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen()); 
       case signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen()); 
        //home
       case home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case chatroom:
        return MaterialPageRoute(builder: (context) => const ChatScreen());


        default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}