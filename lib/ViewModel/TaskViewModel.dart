import 'package:flutter/material.dart';
import 'package:to_do_app3/Model/TaskService.dart';

class TaskViewModel extends ChangeNotifier {
  List toDoList = [];

  TaskViewModel() {
    loadTasks();
  }

  void loadTasks() async {
    toDoList = await TaskService().loadTasks();
    notifyListeners();
  }

  void addTask(String task) {
    toDoList.add([task, false]);
    TaskService().saveTask([task, false]);
    notifyListeners();
  }

  void updateTask(int index) {
    toDoList[index][1] = !toDoList[index][1];
    TaskService().updateTask(index, toDoList[index]);
    notifyListeners();
  }

  void deleteTask(int index) {
    toDoList.removeAt(index);
    TaskService().deleteTask(index);
    notifyListeners();
  }
}