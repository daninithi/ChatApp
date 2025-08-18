import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/strings.dart';
import 'package:chat_app/core/constants/styles.dart';
import 'package:chat_app/core/enums/enums.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/screens/bottom_navigator/chat_list/chat_list_viewmodel.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:chat_app/ui/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});
  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  // int _userCount = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).user;
    return  ChangeNotifierProvider(
      create: (context) => ChatListViewmodel(DatabaseService(), currentUser!),
      child: Consumer<ChatListViewmodel>(
        builder: (context, model, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05),
            child:  Column(
              children: [
                30.verticalSpace,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("chats", style: h),
                ),
                20.verticalSpace,
                CustomTextField(
                  isSearch: true,
                  hintText: "search here",
                  onChanged: model.search,
                ),
                10.verticalSpace,
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    filled: true,
                    // ignore: deprecated_member_use
                    fillColor: grey.withOpacity(0.12),
                    hintText: "search by user ID",
                    hintStyle: body.copyWith(color: grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                10.verticalSpace,
                ElevatedButton(
                  onPressed: () {
                    // Check if the search field is not empty before fetching
                    if (_searchController.text.isNotEmpty) {
                      model.fetchUserById(_searchController.text.trim());
                    }
                  },
                  child: const Text('Search User'),
                ),
                10.verticalSpace,
                model.state == ViewState.loading 
                  ? Expanded(child: const Center(child: CircularProgressIndicator()))
                  : model.chatUsers.isEmpty
                    ? const Center(child: Text("No chats available"))
                    : Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                        itemCount: model.filteredUsers.length,
                        separatorBuilder: (context, index) => 8.verticalSpace,
                        itemBuilder: (context, index) {
                          final user = model.filteredUsers[index];
                          return ChatTile(
                            user: user,
                            onTap: () => Navigator.pushNamed(context, chatroom, arguments: user));
                        },
                      ),
                  ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final UserModel user;
  final void Function()? onTap;

  const ChatTile({
    super.key, this.onTap, required this.user
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      // ignore: deprecated_member_use 
      tileColor: grey.withOpacity(0.12),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: user.imageUrl == null? CircleAvatar(
        backgroundColor: grey,
        radius: 25,
        child: Text(user.name![0].toUpperCase(), style: h2.copyWith(color: white)),
      ):ClipOval(
        child: Image.network(user.imageUrl!,
        height: 50,
        width: 50,
        fit: BoxFit.fill,
        ),
      ),
      title:  Text(user.name!),
      subtitle: const Text(
        "last message",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "15 min ago",
            style: TextStyle(color: grey),
          ),
          10.verticalSpace,
          CircleAvatar(
            radius: 9.r,
            backgroundColor: Primary,
            child: Text(
              "1",
              style: small.copyWith(color: white),
            ),
          )
        ],
      ),
    );
  }
}
