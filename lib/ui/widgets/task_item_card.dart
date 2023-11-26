import 'package:flutter/material.dart';

import '../../data/models/task..dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? ' ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              task.description ?? ' ',
            ),
            Text('Date:  ${task.createdDate} '),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Chip(
                  label: Text(
                   task.status ?? 'New',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.lightBlue,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
