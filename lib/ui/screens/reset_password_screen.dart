import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';

import '../../data/network_caller/network_caller.dart';
import '../../data/network_caller/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_message.dart';

class ResetPasswordScreen extends StatefulWidget {
  String? email;
  String? otp;

  ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();

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
                  const SizedBox(height: 80),
                  Text(
                    'Set Password',
                    // style: Theme.of(context).textTheme.headlineMedium,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Minimum Password length Should be more than 6 letters ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your mobile';
                      }
                      if (value!.length < 6) {
                        return 'Enter password more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (_passwordTEController.text != value) {
                        return 'Password did not match, Try again!';
                      }
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Confirm password';
                      }
                      if (value!.length < 6) {
                        return 'Enter password more than 6 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          _resetPass();
                        },
                        child: const Text('Confirm')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account ?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
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
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
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

  Future<void> _resetPass() async {
    if (_formKey.currentState!.validate()) {
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.recoverResetPassword, body: {
        "email": widget.email,
        "OTP": widget.otp,
        "password": _passwordTEController.text,
      });
      _clearTextFields();
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
          showSnackMessage(context, 'Password Updated.');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'Set password Failed.', true);
        }
      }
    }
  }

  void _clearTextFields() {
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    super.dispose();
  }
}
