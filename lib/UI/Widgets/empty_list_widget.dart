import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Task has been added",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
