import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/login_screen.dart';

class BodyBackground extends StatelessWidget {
  const BodyBackground({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/background.svg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        child
      ],
    );
  }
}
