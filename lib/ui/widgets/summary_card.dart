import 'package:flutter/material.dart';

class SummaryCard extends StatefulWidget {
  const SummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  final String count, title;

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
        child: Column(
          children: [
            Text(
              widget.count,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}
