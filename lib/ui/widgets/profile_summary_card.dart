
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project_rest_api/ui/screens/edit_profile_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {


    return GetBuilder<AuthController>(
      builder: (authController) {
        Uint8List imageBytes = const Base64Decoder().convert(authController.user?.photo??'');
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
          leading: CircleAvatar(
            child: authController.user?.photo == null
                ? const Icon(Icons.person)
                : ClipOval(

              child: Image.memory(
                imageBytes,
                fit: BoxFit.cover,
              ),
              //child:Icon(Icons.abc),
            ),
          ),
          title:  Text(
            fullName(authController),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          subtitle:  Text(
            authController.user?.email??'',
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: ()async{
             AuthController.clearAuthData();
              if(mounted) {
                setState(() {

                });
                Get.offAll(const LoginScreen());
              } },
            icon: Icon(Icons.logout),
          ),
          tileColor: Colors.green,
        );
      }
    );
  }
  String fullName(AuthController authController){
    return  '${authController.user?.firstName??''} ${authController.user?.lastName??''}';
  }
}