import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
//                    onChanged: (value) => inputTitle = value,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              autocorrect: true,
              controller: amountController,
//                    onChanged: (value) => inputAmount = value,
            ),
            FlatButton(
              textColor: Colors.purple,
              child: Text(
                'Add transaction',
              ),
              onPressed: () {
//                      print(inputTitle);
//                      print(inputAmount);
                print(titleController.text);
                print(amountController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
