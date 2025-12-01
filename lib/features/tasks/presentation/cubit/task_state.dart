import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';

enum TaskFilter { all, completed }

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> allTasks;
  final TaskFilter filter;

  const TaskLoaded(this.allTasks, {this.filter = TaskFilter.all});

  List<TaskEntity> get filteredTasks {
    switch (filter) {
      case TaskFilter.all:
        return allTasks.where((task) => !task.isCompleted).toList();
      case TaskFilter.completed:
        return allTasks.where((task) => task.isCompleted).toList();
    }
  }

  @override
  List<Object> get props => [allTasks, filter];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}
