import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTasks extends StatefulWidget {
  final Function addNewTransaction;
  NewTasks(this.addNewTransaction);

  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addNewTransaction(
      _titleController.text,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2022))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onSubmitted: (_) => submitData,
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No chosen date'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose a date',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            color: Color(0xFF64FCDB),
            textColor: Colors.black,
            onPressed: submitData,
            child: Text(
              'Add task',
            ),
          ),
        ],
      ),
    );
  }
}
