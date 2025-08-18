// import 'package:chat_app/ui/screens/Qr/Qr_scan/Qr_scan_viewmodel.dart';
// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'qr_scan_viewmodel.dart';

// class QRScanScreen extends StatefulWidget {
//   const QRScanScreen({super.key});

//   @override
//   State<QRScanScreen> createState() => _QRScanScreenState();
// }

// class _QRScanScreenState extends State<QRScanScreen> {
//   bool _isProcessing = false;

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<QRScanViewModel>(
//       create: (_) => QRScanViewModel(),
//       child: Consumer<QRScanViewModel>(
//         builder: (context, model, _) {
//           return Scaffold(
//             backgroundColor: Colors.grey.shade900,
//             appBar: AppBar(
//               backgroundColor: Colors.grey.shade800,
//               elevation: 1,
//               leading: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//               ),
//               title: const Text(
//                 'Scan QR Code',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             body: SafeArea(
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 280,
//                         height: 280,
//                         decoration: BoxDecoration(
//                           color: Colors.black87,
//                           borderRadius: BorderRadius.circular(24),
//                           border: Border.all(
//                             color: const Color(0xFFEA911D),
//                             width: 3,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.4),
//                               blurRadius: 12,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: Container(
//                                 width: 200,
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Colors.white.withOpacity(0.3),
//                                     width: 2,
//                                   ),
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 child: MobileScanner(
//                                   controller: MobileScannerController(
//                                     detectionSpeed: DetectionSpeed.noDuplicates,
//                                   ),
//                                   onDetect: (capture) async {
//                                     if (_isProcessing) return;
//                                     final barcodes = capture.barcodes;
//                                     if (barcodes.isEmpty) return;

//                                     final raw = barcodes.first.rawValue;
//                                     if (raw == null) return;

//                                     _isProcessing = true;
//                                     final user = await model.processScan(raw, context);
//                                     if (user != null) {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => ChatScreen(receiverId: user.uuid),
//                                         ),
//                                       ).then((_) {
//                                         _isProcessing = false;
//                                       });
//                                     } else {
//                                       if (!mounted) return;
//                                       _showInvalidQRCodeDialog();
//                                       _isProcessing = false;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             // Corner indicators
//                             ...List.generate(4, (index) {
//                               return Positioned(
//                                 top: index < 2 ? 20 : null,
//                                 bottom: index >= 2 ? 20 : null,
//                                 left: index % 2 == 0 ? 20 : null,
//                                 right: index % 2 == 1 ? 20 : null,
//                                 child: Container(
//                                   width: 20,
//                                   height: 20,
//                                   decoration: BoxDecoration(
//                                     border: Border(
//                                       top: index < 2
//                                           ? const BorderSide(
//                                               color: Color(0xFFEA911D),
//                                               width: 3,
//                                             )
//                                           : BorderSide.none,
//                                       bottom: index >= 2
//                                           ? const BorderSide(
//                                               color: Color(0xFFEA911D),
//                                               width: 3,
//                                             )
//                                           : BorderSide.none,
//                                       left: index % 2 == 0
//                                           ? const BorderSide(
//                                               color: Color(0xFFEA911D),
//                                               width: 3,
//                                             )
//                                           : BorderSide.none,
//                                       right: index % 2 == 1
//                                           ? const BorderSide(
//                                               color: Color(0xFFEA911D),
//                                               width: 3,
//                                             )
//                                           : BorderSide.none,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 32),
//                       const Text(
//                         "Scan QR Code",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         "Point your camera at a QR code\nto scan and connect",
//                         style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _showInvalidQRCodeDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Invalid QR Code'),
//           content: const Text('The scanned QR code is not valid or not supported.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }