import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service_locator.dart';
import '../../../../core/text_styles.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../widgets/empty_task_body.dart';
import '../widgets/tasks_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(sl())..loadTasks(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: AppTextStyles.bold24PrimaryDark.copyWith(color: Colors.white),
        ),
        actions: [
          BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              TaskFilter currentFilter = TaskFilter.all;
              if (state is TaskLoaded) {
                currentFilter = state.filter;
              }
              return PopupMenuButton<TaskFilter>(
                initialValue: currentFilter,
                onSelected: (filter) {
                  context.read<TaskCubit>().setFilter(filter);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: TaskFilter.all,
                    child: Text('All (Active)'),
                  ),
                  const PopupMenuItem(
                    value: TaskFilter.completed,
                    child: Text('Completed'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.filteredTasks;
            if (tasks.isEmpty) {
              return EmptyTaskBody(
                message: state.filter == TaskFilter.all
                    ? 'No active tasks'
                    : 'No completed tasks',
              );
            } else {
              return TasksList(tasks: tasks);
            }
          } else if (state is TaskError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: AppTextStyles.regular14Red,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add New Task',
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
                        // Use the context from HomePageView to access the Cubit
                        context.read<TaskCubit>().addTask(controller.text);
                        Navigator.pop(dialogContext);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
