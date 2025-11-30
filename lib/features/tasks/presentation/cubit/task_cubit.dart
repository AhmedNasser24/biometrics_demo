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
      loadTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> toggleTask(TaskEntity task) async {
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await _taskRepository.updateTask(updatedTask);
      loadTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepository.deleteTask(id);
      loadTasks();
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
