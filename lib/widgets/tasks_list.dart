import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:todoey/models/databasehelper.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/widgets/task_tile.dart';

class TasksList extends StatefulWidget {
  TasksList({this.tasks, this.longPressCallback});
  final List<Task> tasks;
  final Function longPressCallback;

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final dbHelper = DatabaseHelper.instance;

  void _updateCheckbox(Task task) async {
    print(task.isDone.toString());
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: task.id,
      DatabaseHelper.columnName: task.name,
      DatabaseHelper.columnIsDone: task.isDone ? 1 : 0,
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () {
            widget.longPressCallback(index);
          },
          child: TaskTile(
            taskTitle: widget.tasks[index].name,
            isChecked: widget.tasks[index].isDone,
            checkboxCallback: (checkboxState) {
              setState(() {
                widget.tasks[index].toggleDone();
                _updateCheckbox(widget.tasks[index]);
              });
            },
          ),
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
