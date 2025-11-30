import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/text_styles.dart';
import '../../domain/entities/task_entity.dart';
import '../cubit/task_cubit.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: task.isCompleted,
          activeColor: theme.colorScheme.secondary,
          onChanged: (_) {
            context.read<TaskCubit>().toggleTask(task);
          },
        ),
        title: Text(
          task.title,
          style: AppTextStyles.regular16black87.copyWith(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : theme.colorScheme.onSurface,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            context.read<TaskCubit>().deleteTask(task.id);
          },
        ),
      ),
    );
  }
}
