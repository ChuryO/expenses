import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addNewTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              autocorrect: true,
              controller: amountController,
            ),
            FlatButton(
              textColor: Colors.purple,
              child: Text(
                'Add transaction',
              ),
              onPressed: () {
                addNewTransaction(
                  titleController.text,
                  double.tryParse(amountController.text) ?? (0.0),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
