// import 'package:chat_app/ui/screens/Qr/QR_gen/Qr_gen_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:pretty_qr_code/pretty_qr_code.dart';
// import 'package:provider/provider.dart';


// class QRGenerateScreen extends StatelessWidget {
//   const QRGenerateScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<QRGenerateViewModel>(
//       create: (_) => QRGenerateViewModel()..loadUserDataAndGenerateQR(),
//       child: Consumer<QRGenerateViewModel>(
//         builder: (context, model, _) {
//           return Scaffold(
           
//             appBar: AppBar(
             
//               leading: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(Icons.arrow_back, color: Colors.black),
//               ),
              
//             ),
//             body: SafeArea(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: model.isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(16),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 10,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               // ignore: deprecated_member_use
//                               child: PrettyQr(
//                                 data: model.qrData,
//                                 size: 200,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               "Your QR Code",
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             Text(
//                               "Others can scan this QR code\nto start chatting with you",
//                               style: TextStyle(fontSize: 16, color: Colors.black),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }