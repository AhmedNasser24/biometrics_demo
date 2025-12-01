import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/text_styles.dart';
import '../../domain/entities/task_entity.dart';
import '../cubit/task_cubit.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;

  const TaskItem({super.key, required this.task});

  void _showEditTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController(
      text: task.title,
    );
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Task',
                style: AppTextStyles.semiBold20PrimaryDark,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter task title',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                style: AppTextStyles.regular16black87,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.regular14black87.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        context.read<TaskCubit>().updateTaskTitle(
                          task.id,
                          controller.text,
                        );
                        Navigator.pop(dialogContext);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        onTap: () => _showEditTaskDialog(context),
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
