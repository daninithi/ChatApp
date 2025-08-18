import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('My QR Code', style: h),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () => Navigator.pushNamed(context, 'qrScanner'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentUser != null) ...[
              QrImageView(
                data: currentUser.uid!,
                version: QrVersions.auto,
                size: 200.0,
              ),
              20.verticalSpace,
              Text(
                'Scan to chat with me',
                style: body.copyWith(color: grey),
              ),
              10.verticalSpace,
              Text(
                currentUser.name ?? '',
                style: h2,
              ),
            ],
          ],
        ),
      ),
    );
  }
}