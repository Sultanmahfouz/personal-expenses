import 'package:flutter/material.dart';
import 'package:flutter_guide/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransaction;

  TransactionsList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text('\$${transactions[index].amount}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  deleteTransaction(transactions[index].id);
                },
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}

// return Card(
//   child: Row(
//     children: [
//       Container(
//         padding: EdgeInsets.all(10),
//         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//         child: Text(
//           '\$${transactions[index].amount.toStringAsFixed(2)}',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Theme.of(context).primaryColor,
//           ),
//         ),
//       ),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             transactions[index].title,
//             style:
//                 TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             DateFormat.yMMMEd().format(transactions[index].date),
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     ],
//   ),
// );
