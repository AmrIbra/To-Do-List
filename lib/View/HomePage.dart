import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app3/ViewModel/TaskViewModel.dart';
import 'TodoList.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tasksBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (_) => TaskViewModel(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Today's tasks"),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.toDoList.length,
            itemBuilder: (context, index) {
              return TodoList(
                taskName: viewModel.toDoList[index][0],
                taskCompleted: viewModel.toDoList[index][1],
                onChanged: (value) => viewModel.updateTask(index),
                deleteFunction: (context) => viewModel.deleteTask(index),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo item',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                context.read<TaskViewModel>().addTask(_controller.text);
                _controller.clear();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}