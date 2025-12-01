import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/task_entity.dart';
import 'task_item.dart';

class TasksList extends StatelessWidget {
  final List<TaskEntity> tasks;

  const TasksList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
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
