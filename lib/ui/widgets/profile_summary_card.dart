import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/edit_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (enableOnTap == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(),
            ),
          );
        }
      },
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        'Shakib Absar',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        'sabsar42@gmail.com',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailing:
          enableOnTap ? const Icon(Icons.arrow_forward_ios_outlined) : null,
      tileColor: Colors.green,
    );
  }
}
