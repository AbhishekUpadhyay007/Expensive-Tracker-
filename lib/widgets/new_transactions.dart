import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addNewTransactions;

  NewTransactions(this.addNewTransactions);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final title = TextEditingController();
  final cost = TextEditingController();
  DateTime _selectedDate;

  void _submit() {
    final text = title.text;
    final amount = double.parse(cost.text);
    if (cost == null) {
      return;
    }

    if (text.isEmpty || amount.isNegative || _selectedDate == null) {
      return;
    }

    widget.addNewTransactions(text, amount, _selectedDate);

    Navigator.of(context)
        .pop(); // this function close the uppermost screen of the app during submit
  }

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontFamily: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .title
                        .fontFamily),
                controller: title,
                onSubmitted: (val) => _submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                controller: cost,
                style: TextStyle(
                    fontFamily: Theme.of(context)
                        .appBarTheme
                        .textTheme
                        .title
                        .fontFamily),
                onSubmitted: (val) => _submit(),
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          _selectedDate == null
                              ? 'No Date Choosen'
                              : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                          style: TextStyle(
                            fontFamily:
                                Theme.of(context).textTheme.title.fontFamily,
                          )),
                    ),
                    FlatButton(
                        onPressed: _openDatePicker,
                        child: Text('Choose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontFamily:
                                  Theme.of(context).textTheme.title.fontFamily,
                            ))),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submit,
                child: Text(
                  'Add Transaction',
                ),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
