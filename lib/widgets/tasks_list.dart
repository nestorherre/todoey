import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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
              });
            },
          ),
        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
