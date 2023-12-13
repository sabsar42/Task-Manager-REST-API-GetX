import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/reset_password_screen.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_message.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEController = TextEditingController();
  bool _otpVerifyInProgess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'A 6 digit OTP will be sent to your email address',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PinCodeTextField(
                      controller: _otpTEController,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.green,
                        inactiveColor: Colors.blue,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _otpVerifyInProgess == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            otpVerify();
                          },
                          child: const Text('Verify'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> otpVerify() async {
    if (_formKey.currentState!.validate()) {
      _otpVerifyInProgess = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response = await NetworkCaller()
          .getRequest(Urls.recoveryOTPUrl(widget.email, _otpTEController.text));
      _otpVerifyInProgess = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {

        if (mounted) {
          showSnackMessage(context, 'OTP is Verified');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                    email: widget.email, otp: _otpTEController.text)),
          );
        } else {
          if (mounted) {
            showSnackMessage(
                context, 'OTP verfication failed. Try again!', true);
            Navigator.pop(context);
          }
        }
      }
    }
  }
}
