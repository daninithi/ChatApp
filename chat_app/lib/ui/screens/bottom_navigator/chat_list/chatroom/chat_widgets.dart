import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class BottomFeild extends StatelessWidget {
  const BottomFeild({
    super.key, this.onTap, this.onChanged, this.controller
  });

final void Function()? onTap;
final void Function(String)? onChanged;
final TextEditingController? controller;

Future<void> _pickFile(BuildContext context, FileType type) async {
    Navigator.pop(context);
    final result = await FilePicker.platform.pickFiles(type: type);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selected: ${file.name}')));
    }
}

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Photos'),
              onTap: () => _pickFile(context, FileType.image),
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Videos'),
              onTap: () => _pickFile(context, FileType.video),
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('Document'),
              onTap: () => _pickFile(context, FileType.any),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 20.h),
      child: Row(
        children: [
         InkWell(
          onTap: () => _showAttachmentOptions(context),
           child: CircleAvatar(
            radius: 20.r,
            backgroundColor: white,
            child: Icon(Icons.add),
                         ),
         ),
    
        10.horizontalSpace,
        Expanded(
          child: 
          CustomTextField(
            controller: controller,
            isChatText: true,
            hintText: "Type a message",
            onChanged: onChanged,
            onTap: onTap,
          ),
        )
      ],
     ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key, this.isCurrentUser = true, required this.message
  });

  final bool isCurrentUser;
  final Message message;


  @override
  Widget build(BuildContext context) {
    final borderRadius = isCurrentUser? BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
          ):
          BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
          );
    final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft; 
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1.sw * 0.75, minWidth: 50.w),
        padding: const EdgeInsets.all(10),
        // ignore: deprecated_member_use
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: isCurrentUser ? Primary : grey.withOpacity(0.2),
          borderRadius: borderRadius
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(
              message.content!,
              style: body.copyWith(
                color: isCurrentUser ? white : null,
              ),
            ),
            5.verticalSpace,
            Text(
              DateFormat('hh:mm a').format(message.timestamp!),
              style: small.copyWith(
                color: isCurrentUser? white: null,
              ),
            )
          ],
        ),

      ),
    );
  }
}
