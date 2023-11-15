import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/pin_verfication_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/sign_up_screen.dart';
import 'package:task_manager_project_rest_api/ui/widgets/body_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      'Your Email Address',
                      // style: Theme.of(context).textTheme.headlineMedium,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('A 6 digit PIN will be sent to your Email',style:
                      TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey

                      ),),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> const PinVerificationScreen()),
                          );
                        },
                        child: const Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account ?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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
          )),
    );
  }
}
