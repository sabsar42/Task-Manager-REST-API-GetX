import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_message.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  String _messsage = '';

  String get message => _messsage;

  bool get signUpInProgress => _signUpInProgress;

  Future<bool> signUp(
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? password,
  ) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registration, body: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "mobile": mobile,
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      isSuccess = true;
      _messsage = 'Account has been created! Please login.';
    } else {
      _messsage = 'Account creation failed! Please try again.';
      isSuccess = false;
    }
    return isSuccess;
  }
}
