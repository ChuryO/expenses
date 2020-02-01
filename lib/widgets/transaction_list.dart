import 'package:first_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
//            reverse: true,
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
                      padding: EdgeInsets.all(6),
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
                    icon: Icon(Icons.delete_forever),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
            },
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          );
  }
}
