import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';

class BottomFeild extends StatelessWidget {
  const BottomFeild({super.key, this.onTap, this.onChanged});

  final void Function()? onTap;
  final void Function(String)? onChanged;

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
              radius: 25.r,
              backgroundColor: white,
              child: const Icon(Icons.add),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: CustomTextField(
              isChatText: true,
              hintText: "Type a message",
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
