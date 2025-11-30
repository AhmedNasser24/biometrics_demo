import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SharedPreferences _prefs;
  static const String _tasksKey = 'tasks_key';

  TaskRepositoryImpl(this._prefs);

  @override
  Future<List<TaskEntity>> getTasks() async {
    final String? tasksString = _prefs.getString(_tasksKey);
    if (tasksString == null) return [];
    return TaskModel.decode(tasksString);
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final List<TaskEntity> currentTasks = await getTasks();
    final List<TaskModel> newTasks = [
      ...currentTasks.map((e) => TaskModel.fromEntity(e)),
      TaskModel.fromEntity(task),
    ];
    await _prefs.setString(_tasksKey, TaskModel.encode(newTasks));
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final List<TaskEntity> currentTasks = await getTasks();
    final List<TaskModel> newTasks = currentTasks.map((e) {
      if (e.id == task.id) {
        return TaskModel.fromEntity(task);
      }
      return TaskModel.fromEntity(e);
    }).toList();
    await _prefs.setString(_tasksKey, TaskModel.encode(newTasks));
  }

  @override
  Future<void> deleteTask(String id) async {
    final List<TaskEntity> currentTasks = await getTasks();
    final List<TaskModel> newTasks = currentTasks
        .where((e) => e.id != id)
        .map((e) => TaskModel.fromEntity(e))
        .toList();
    await _prefs.setString(_tasksKey, TaskModel.encode(newTasks));
  }
}
