import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project_rest_api/ui/screens/add_new_tasks_screen.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_item_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNewTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(//44min
          children: [
            ProfileSummaryCard(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    SummaryCard(
                      count: '92',
                      title: 'New',
                    ),
                    SummaryCard(
                      count: '92',
                      title: 'In-Progress',
                    ),
                    SummaryCard(
                      count: '92',
                      title: 'Completed',
                    ),
                    SummaryCard(
                      count: '92',
                      title: 'Cancelled',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const TaskItemCard();
                    }))
          ],
        ),
      ),
    );
  }
}
