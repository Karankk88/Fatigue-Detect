import 'package:flutter/material.dart';

class FatigueGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text('Graph Placeholder', style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}