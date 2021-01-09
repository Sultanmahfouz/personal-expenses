import 'package:flutter/material.dart';
import 'package:flutter_guide/widgets/new_tasks.dart';
import 'package:flutter_guide/widgets/tasks_list.dart';
import 'models/tasks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String titleInput;
  String amountInput;

  final List<Tasks> _userTasks = [
    // Tasks(title: 'Go to the gym', date: DateTime(2021, 1, 5), id: '1234543211'),
  ];

  void _addNewTask(String taskTitle, DateTime chosenDate) {
    final newTask = Tasks(
      title: taskTitle,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTasks.add(newTask);
    });
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTasks(_addNewTask),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTask(String id) {
    setState(() {
      _userTasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: _userTasks.length == 0
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 40, right: 140),
                          child: Text(
                            'My Tasks',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50.0, left: 50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset('image.gif',
                                height: 200, fit: BoxFit.fill),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 80.0, left: 50),
                          child: Text(
                            'There are no tasks\n       Add a task',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 40, right: 200),
                          child: Text(
                            'My Tasks',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TasksList(_userTasks, _deleteTask),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTask(context),
      ),
    );
  }
}
