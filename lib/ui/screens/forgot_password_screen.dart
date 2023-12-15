import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/controllers/forgot_password_contoller.dart';
import 'package:task_manager_project_rest_api/ui/screens/pin_verification_screen.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_caller.dart';
import 'package:task_manager_project_rest_api/data/network_caller/network_response.dart';
import 'package:task_manager_project_rest_api/data/utility/urls.dart';
import 'package:task_manager_project_rest_api/ui/widgets/snack_message.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  ForgotPasswordController _forgotPasswordController = Get.find<ForgotPasswordController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 99,
                  ),
                  Text(
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "A 6 digit OTP will be sent to your email address",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
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
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<ForgotPasswordController>(
                        builder: (forgotPasswordController) {
                      return Visibility(
                        visible:
                            forgotPasswordController.forgetPasswordInProgress ==
                                false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            forgetPassword();
                          },
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have  an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();

                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> forgetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await _forgotPasswordController
        .forgetPassword(_emailTEController.text.trim());
    if (response) {
      if (mounted) {
        showSnackMessage(context, _forgotPasswordController.message);
        Get.offAll(
            () => PinVerificationScreen(email: _emailTEController.text.trim()));
      } else {
        if (mounted) {
          showSnackMessage(context, _forgotPasswordController.message, true);
        }
      }
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
