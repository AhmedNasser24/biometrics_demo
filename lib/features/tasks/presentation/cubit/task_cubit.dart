import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit(this._taskRepository) : super(TaskInitial());

  Future<void> loadTasks() async {
    emit(TaskLoading());
    try {
      final tasks = await _taskRepository.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> addTask(String title) async {
    try {
      final task = TaskEntity(id: const Uuid().v4(), title: title);
      await _taskRepository.addTask(task);
      _refreshTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> toggleTask(TaskEntity task) async {
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await _taskRepository.updateTask(updatedTask);
      _refreshTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepository.deleteTask(id);
      _refreshTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateTaskTitle(String id, String newTitle) async {
    try {
      // We need to find the task first to keep other properties
      final currentState = state;
      if (currentState is TaskLoaded) {
        final task = currentState.allTasks.firstWhere((t) => t.id == id);
        final updatedTask = task.copyWith(title: newTitle);
        await _taskRepository.updateTask(updatedTask);
        _refreshTasks();
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  void setFilter(TaskFilter filter) {
    final currentState = state;
    if (currentState is TaskLoaded) {
      emit(TaskLoaded(currentState.allTasks, filter: filter));
    }
  }

  Future<void> _refreshTasks() async {
    try {
      final tasks = await _taskRepository.getTasks();
      final currentState = state;
      if (currentState is TaskLoaded) {
        emit(TaskLoaded(tasks, filter: currentState.filter));
      } else {
        emit(TaskLoaded(tasks));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
