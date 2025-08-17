// // import 'package:chat_app/core/enums/enums.dart';
// // import 'package:chat_app/core/services/auth_service.dart';
// // import 'package:chat_app/core/services/database_service.dart';
// // import 'package:chat_app/ui/screens/home/home_viewmodel.dart';
// // import 'package:chat_app/ui/screens/other/user_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final userProvider = Provider.of<UserProvider>(context);
// //     return ChangeNotifierProvider(
// //       create:(context) => HomeViewmodel(DatabaseService()),
// //       child: Consumer<HomeViewmodel>(
// //         builder: (context, model, _) {
// //           return Scaffold(
// //             body: Center(
// //               child: userProvider.user == null
// //                     ? const CircularProgressIndicator()
// //                     : InkWell (
// //                       onTap: () {
// //                         AuthService().logout();
// //                         Navigator.pushReplacementNamed(context, login);
// //                         },
// //                         child: Text(userProvider.user.toString())),
// //             ),
// //           );
// //         }
// //       ),
// //     );
// //   }
// // }

// import 'package:chat_app/core/services/auth_service.dart';
// import 'package:chat_app/ui/screens/other/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   // A local method to handle the logout logic
//   void _handleLogout(BuildContext context) async {
//     // We get the UserProvider and clear the user data immediately.
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     userProvider.clearUser();

//     // Now, we tell AuthService to log out.
//     // We do NOT add any navigation here.
//     // The Wrapper widget will handle the navigation after this.
//     await AuthService().logout();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       body: Center(
//         child: userProvider.user == null
//             ? const CircularProgressIndicator()
//             : InkWell(
//                 onTap: () => _handleLogout(context), // Call the correct logout method
//                 child: Text('User logged in: ${userProvider.user.toString()}'),
//               ),
//       ),
//     );
//   }
// }