import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title Will be here ',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),),
            const Text('Description '),
            const Text('Date: 12-20-23 '),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Chip(label: Text('New ',style: TextStyle(
                  color: Colors.white,
                ),),
                  backgroundColor: Colors.lightBlue,
                ),
                Wrap(
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.edit),),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete),)
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
