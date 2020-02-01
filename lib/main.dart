import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  /// only vertical orientation
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses',
      home: MyHomePage(),

      /// definition custom themes
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.grey,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 20,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Creating dummy transactions
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  /// Filtering transactions for a last 7 days
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txElement) {
      return txElement.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  ///
  bool _showChart = false;

  /// Adding new transaction method
  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  ///Removing transaction method
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  /// Opening popup sheet for add transaction
  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  /// calc height method
  double _calculateHeight(AppBar appBar) {
    final ctx = MediaQuery.of(context);
    return ctx.size.height - appBar.preferredSize.height - ctx.padding.top;
  }

  @override
  Widget build(BuildContext context) {
    /// add AppBar into var to calc height
    final appBar = AppBar(
      title: const Text('Personal expenses'),
      elevation: 5,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    /// check screen orientation
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final _txListWidget = Container(
      height: _calculateHeight(appBar) * .7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!_isLandscape)
              Container(
                height: _calculateHeight(appBar) * .3,
                child: Chart(_recentTransactions),
              ),
            if (!_isLandscape) _txListWidget,
            if (_isLandscape)
              _showChart
                  ? Container(
                      height: _calculateHeight(appBar) * .7,
                      child: Chart(_recentTransactions),
                    )
                  : _txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
