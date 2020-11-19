import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './widgets/transactions_list.dart';
import './widgets/new_transactions.dart';
import './models/Transaction.dart';
import './widgets/Chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Task app',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
      home: MyTaskApp(),
    );
  }
}

class MyTaskApp extends StatefulWidget {
  @override
  _TaskApp createState() => _TaskApp();
}

class _TaskApp extends State<MyTaskApp> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'Task 1',
    //   name: 'New Shoes',
    //   cost: 450,
    //   dateTime: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'Task 2',
    //   name: 'Vegetables',
    //   cost: 150,
    //   dateTime: DateTime.now(),
  ];

  bool _showBars = false;

  void _addNewTransactions(String title, double amount, DateTime date) {
    final newTx = Transaction(
      name: title,
      cost: amount,
      dateTime: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTransactions(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _openAddTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransactions(_addNewTransactions),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isAndroid
        ? AppBar(
            title: Text('Peronal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _openAddTransactionSheet(context);
                },
              )
            ],
          )
        : CupertinoNavigationBar(
            middle: Text('Expensive Tracker'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _openAddTransactionSheet(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
        );

    final txWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionsList(_userTransactions, _removeTransactions));

    return Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show Chart'),
                      Switch(
                        onChanged: (val) {
                          setState(() {
                            _showBars = val;
                          });
                        },
                        value: _showBars,
                      ),
                    ],
                  ),
                if (isLandscape)
                  _showBars
                      ? Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.5,
                          child: Chart(_recentTransactions))
                      : txWidget,
                if (!isLandscape)
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.25,
                      child: Chart(_recentTransactions)),
                if (!isLandscape) txWidget,
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isAndroid
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => _openAddTransactionSheet(context),
              )
            : Container());
  }
}
