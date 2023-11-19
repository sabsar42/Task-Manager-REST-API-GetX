import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project_rest_api/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  final bool enableOnTap;

  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.enableOnTap == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfileScreen(),
            ),
          );
        }
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        fullName,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        AuthController.user?.email ?? ' ',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
      tileColor: Colors.green,
    );
  }
}

String get fullName {
  return '${AuthController.user?.firstName ?? ' '} ${AuthController.user?.lastName ?? ' '}';
}
