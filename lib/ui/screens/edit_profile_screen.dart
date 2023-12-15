import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';
import 'package:task_manager_project_rest_api/ui/widgets/profile_summary_card.dart';
import 'dart:convert';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../controllers/auth_controllers.dart';
import '../controllers/edit_profile_controller.dart';
import '../widgets/snack_message.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  EditProfileController _editProfileController = Get.find<EditProfileController>();
  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = authController.user?.email ?? '';
    _firstNameTEController.text = authController.user?.firstName ?? '';
    _lastNameTEController.text = authController.user?.lastName ?? '';
    _mobileTEController.text = authController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(
              enableOnTap: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Update Profile',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          photoPickerField(),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _emailTEController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter an email';
                              }

                              bool emailValid = RegExp(
                                      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                  .hasMatch(value!);
                              if (emailValid == false) {
                                return 'Enter valid Email';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _firstNameTEController,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your First Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _lastNameTEController,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter your Last Name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _mobileTEController,
                            decoration: const InputDecoration(
                              hintText: 'Mobile',
                            ),
                            validator: (String? value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Enter valid Phone Number';
                              }

                              bool validPhone =
                                  RegExp(r'^01[3-9][0-9]{8}$').hasMatch(value!);
                              if (validPhone == false) {
                                return 'Enter valid Phone Number';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _passwordTEController,
                            decoration: const InputDecoration(
                              hintText: 'Password (Optional)',
                            ),
                            validator: (String? value) {
                              if (value!.length < 6 && value.isNotEmpty) {
                                return 'Enter Password more than 6 letters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<EditProfileController>(
                                builder: (editProfileController) {
                              return Visibility(
                                visible: editProfileController
                                        .updateProfileInProgress ==
                                    false,
                                replacement: const Center(
                                    child: CircularProgressIndicator()),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateProfile();
                                    }
                                  },
                                  child: const Icon(Icons.arrow_forward_ios),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    final response = await _editProfileController.updateProfile(
      _firstNameTEController.text.trim(),
      _lastNameTEController.text.trim(),
      _emailTEController.text.trim(),
      _mobileTEController.text.trim(),
      _passwordTEController.text,
      photo,
    );

    if (response) {
      _clearTextFields();
      if (mounted) {
        showSnackMessage(context, _editProfileController.message);
        Get.offAll(() =>  MainBottomNavScreen());
      }
    } else {
      if (mounted) {
        showSnackMessage(context, _editProfileController.message);
      }
    }
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Visibility(
                  visible: photo == null,
                  replacement: Text(photo?.name ?? ''),
                  child: const Text('Select a photo'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
