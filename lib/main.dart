import 'package:flutter/material.dart';
import 'package:flutter_guide/widgets/chart.dart';
import 'package:flutter_guide/widgets/new_transactions.dart';
import 'package:flutter_guide/widgets/transactions_list.dart';

import 'models/transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ),
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

  final List<Transactions> _userTransactions = [
    // Transactions(
    //   title: 'weekle grocery',
    //   amount: 19.99,
    //   date: DateTime.now(),
    //   id: '12345',
    // ),
    // Transactions(
    //   title: 'new bag',
    //   amount: 18.04,
    //   date: DateTime.now(),
    //   id: '12345',
    // ),
  ];

  List<Transactions> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transactions(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransactions(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_userTransactions.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _userTransactions.length == 0
            ? Text('No transactions yet')
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Chart(_recentTransactions),
                  TransactionsList(_userTransactions, _deleteTransaction),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
