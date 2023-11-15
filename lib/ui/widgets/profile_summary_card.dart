import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


class ProfileSummaryCard extends StatelessWidget {
  const ProfileSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),

      title: Text('Shakib Absar'
        ,
        style: TextStyle(
          color: Colors.white,
        ),),
      subtitle: Text('sabsar42@gmail.com',
        style: TextStyle(
          color: Colors.white,
        ),),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      tileColor: Colors.green,
    );
  }
}

