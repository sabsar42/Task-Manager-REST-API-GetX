import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/controllers/reset_password_controller.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/reset_password_screen.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_message.dart';
import 'package:get/get.dart';

class PinVerificationController extends GetxController {
  bool _otpVerifyInProgess = false;

  bool get otpVerifyInProgess => _otpVerifyInProgess;
  String _message = '';

  String get message => _message;

  Future<bool> otpVerify(String email, String otp) async {
    bool isSuccess = false;
    _otpVerifyInProgess = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.recoveryOTPUrl(email, otp));
    _otpVerifyInProgess = false;
    update();
    print('This => ${response.isSuccess}');
    if (response.isSuccess) {
      isSuccess = true;
      _message = 'OTP is Verified';

    } else {
      _message = 'OTP verfication failed. Try again!';
      isSuccess = false;print(_message);
    }
    update();
    return isSuccess;
  }
}
