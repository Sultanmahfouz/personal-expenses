import 'package:flutter/material.dart';
import 'package:flutter_guide/models/tasks.dart';
import 'package:intl/intl.dart';

class TasksList extends StatelessWidget {
  final List<Tasks> tasks;
  final Function deleteTask;

  TasksList(this.tasks, this.deleteTask);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
            child: ListTile(
              leading: Icon(
                Icons.check_box,
                size: 45,
                color: Color(0xFF64FCDB),
              ),
              title: Text(
                tasks[index].title,
                // ignore: deprecated_member_use
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(tasks[index].date),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  deleteTask(tasks[index].id);
                },
              ),
            ),
          );
        },
        itemCount: tasks.length,
      ),
    );
  }
}
