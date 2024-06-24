import 'package:flutter/material.dart';
import 'package:task_manager/database/database_helper.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/screens/add_edit_task_screen.dart';
import 'package:task_manager/screens/task_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  _refreshTaskList() async {
    List<Task> x = await DatabaseHelper.instance.getTaskList();
    setState(() {
      tasks = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(task: tasks[index]),
                ),
              ).then((value) {
                _refreshTaskList();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditTaskScreen(),
            ),
          ).then((value) {
            _refreshTaskList();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
