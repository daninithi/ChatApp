import 'package:chat_app/core/services/auth_service.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/screens/profile/profile_viewmodel.dart';
import 'package:chat_app/ui/screens/other/user_provider.dart';
import 'package:chat_app/ui/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => ProfileViewmodel(DatabaseService()),
      child: Consumer<ProfileViewmodel>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: Center(
              child: userProvider.user == null
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    userProvider.user!.name?.isNotEmpty == true
                                        ? userProvider.user!.name![0].toUpperCase()
                                        : '',
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  userProvider.user!.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  userProvider.user!.email ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[700],
                                  ),
                                ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 400, // Set your desired width
                          child: CustomButton(
                            text: 'Log Out',
                            onPressed: () {
                              AuthService().logout();
                              Provider.of<UserProvider>(context).clearUser();
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}