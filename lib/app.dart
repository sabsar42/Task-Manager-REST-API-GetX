import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: SplashScreen(),

    );
  }
}
