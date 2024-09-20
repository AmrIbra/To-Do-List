import 'package:hive/hive.dart';

class TaskService {
  void saveTask(List task) {
    var box = Hive.box('tasksBox');
    box.add(task);
  }

  List<List<dynamic>> loadTasks() {
    var box = Hive.box('tasksBox');
    return box.values.map((task) => [task[0], task[1]]).toList();
  }

  void deleteTask(int index) {
    var box = Hive.box('tasksBox');
    box.deleteAt(index);
  }

  void updateTask(int index, List task) {
    var box = Hive.box('tasksBox');
    box.putAt(index, task);
  }
}