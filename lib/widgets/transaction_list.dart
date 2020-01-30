import 'package:first_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isNotEmpty
          ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 20,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.remove), onPressed: () => {}),
                  ),
                );
//                return Card(
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        child: Text(
//                          '\$${transactions[index].amount.toStringAsFixed(2)}',
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 20,
//                            color: Theme.of(context).primaryColorDark,
//                          ),
//                        ),
//                        margin: EdgeInsets.symmetric(
//                          vertical: 10,
//                          horizontal: 15,
//                        ),
//                        padding: EdgeInsets.all(10),
//                        decoration: BoxDecoration(
//                          border: Border.all(
//                            color: Theme.of(context).primaryColorDark,
//                            width: 2,
//                          ),
//                          borderRadius: BorderRadius.circular(3),
//                        ),
//                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Text(
//                            transactions[index].title,
//                            style: Theme.of(context).textTheme.title,
//                          ),
//                          Text(
//                            DateFormat()
//                                .add_yMMMd()
//                                .format(transactions[index].date),
//                            textAlign: TextAlign.left,
//                            style: TextStyle(
//                              color: Theme.of(context).primaryColorDark,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                );
              },
            )
          : Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
    );
  }
}
