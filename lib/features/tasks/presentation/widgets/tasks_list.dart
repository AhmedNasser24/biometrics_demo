import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/task_entity.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks});
  final List<TaskEntity> tasks;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet layout: Centered container with max width
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: _buildAnimatedList(tasks),
            ),
          );
        } else {
          // Mobile layout: Full width
          return _buildAnimatedList(tasks);
        }
      },
    );
  }

  Widget _buildAnimatedList(List<TaskEntity> tasks) {
    return ImplicitlyAnimatedList<TaskEntity>(
      items: tasks,
      areItemsTheSame: (a, b) => a.id == b.id,
      itemBuilder: (context, animation, item, index) {
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: TaskItem(task: item),
        );
      },
    );
  }
}
