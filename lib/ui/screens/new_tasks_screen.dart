import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_summary_card.dart';
import '../widgets/summary_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(//44min
          children: [
            ProfileSummaryCard(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
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
            Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text('Title Will be here ',style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),),
                        Text('Description '),
                        Text('Date: 12-20-23 '),
                            Chip(label: Text('New ',style: TextStyle(
                             color: Colors.white,
                            ),),
                              backgroundColor: Colors.lightBlue,
                            )
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
