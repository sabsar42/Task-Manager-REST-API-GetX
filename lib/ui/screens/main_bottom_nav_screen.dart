import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/Cancelled_tasks_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/completed_tasks_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/new_tasks_screen.dart';
import 'package:task_manager_project_rest_api/ui/screens/progress_tasks_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  int _selectedIndex = 0 ;
  List<Widget> _screens = [
    NewTasksScreen(),
    ProgressTasksScreen(),
    CompletedTasksScreen(),
    CancelledTasksScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex ,
          onTap: (index){
            _selectedIndex = index;
            setState(() {

            });
          },
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'New'),
        BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf), label: 'In-progress'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Completed'),
        BottomNavigationBarItem(icon: Icon(Icons.contact_page_outlined), label: 'Cancelled'),
      ]),
    );
  }
}
