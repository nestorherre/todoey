import 'package:flutter/material.dart';
import 'package:todoey/models/databasehelper.dart';
import 'package:todoey/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({this.addTaskCallback});
  final Function addTaskCallback;

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskText;
  final dbHelper = DatabaseHelper.instance;

  void _insert(Task task) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: task.name,
      DatabaseHelper.columnIsDone: task.isDone ? 1 : 0,
    };
    await dbHelper.insert(row);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                taskText = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              onPressed: () async {
                // widget.addTaskCallback(
                //   Task(name: taskText),
                // );
                _insert(
                  Task(name: taskText),
                );
                int newTaskID = await dbHelper.queryRowCount();
                widget.addTaskCallback(Task(id: newTaskID, name: taskText));
                Navigator.pop(context);
              },
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
