import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;
  TransactionsList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: double.infinity,
      child: _userTransactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      "No Transactions yet!",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: constraints.maxHeight * 0.65,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  elevation: 5,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              '\u20B9${_userTransactions[index].cost}',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        _userTransactions[index].name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(DateFormat.yMMMMd()
                          .format(_userTransactions[index].dateTime)),
                      trailing: mediaQuery.size.width < 400
                          ? IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () =>
                                  deleteTx(_userTransactions[index].id),
                            )
                          : FlatButton.icon(
                              onPressed: () =>
                                  deleteTx(_userTransactions[index].id),
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor),
                ));
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
