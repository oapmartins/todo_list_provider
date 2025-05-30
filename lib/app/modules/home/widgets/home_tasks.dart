import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('TASK\'S ', style: context.titleStyle),
          Column(
            children: [
              // Task(
              //   taskModel: TaskModel(
              //     id: 23,
              //     description: ' description',
              //     dateTime: DateTime.now(),
              //     finished: true,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
