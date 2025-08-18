// import 'package:flutter/material.dart';
// import 'dart:convert';


// class QRScanViewModel extends ChangeNotifier {
//   bool isProcessing = false;

//   Future<User?> processScan(String raw, BuildContext context) async {
//     try {
//       final Map<String, dynamic> data = jsonDecode(raw);
//       if (data.containsKey('email') && data['email'] is String) {
//         final scannedUserUuid = data['uuid'] as String?;
//         final scannedUserEmail = data['email'] as String;
//         final scannedUserName = data['name'] as String?;

//         if (scannedUserUuid != null && scannedUserName != null) {
//           final now = DateTime.now().toIso8601String();
//           final newUser = User(
//             uuid: scannedUserUuid,
//             email: scannedUserEmail,
//             name: scannedUserName,
//             createdAt: now,
//             updatedAt: now,
//           );

//           final repo = Repository();
//           await repo.insertUser(newUser);
//           return newUser;
//         }
//       }
//     } catch (e) {
//       // Handle error if needed
//     }
//     return null;
//   }
// }