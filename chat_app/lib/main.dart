import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/core/services/firebaseMessaging_service.dart';
import 'package:chat_app/core/services/local_notification_service.dart';
import 'package:chat_app/core/utils/route_utils.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/ui/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // To use other Firebase services in the background, such as Firestore,
  // you must call `Firebase.initializeApp` before using them.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final localNotificationService = LocalNotificationService.instance();
  await localNotificationService.init();
  final firebaseMessagingService = FirebaseMessagingService.instance();
  await firebaseMessagingService.init(localNotificationsService: localNotificationService);
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => ChangeNotifierProvider(
        create: (context) => UserProvider(DatabaseService()),
        child: const MaterialApp(
            onGenerateRoute: RouteUtils.onGenerateRoute,
            // home: Wrapper(),
            home: SplashScreen(),
          ),
      ),
    );
  }
}