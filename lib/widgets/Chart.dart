import './chart_bars.dart';
import 'package:flutter/material.dart';
import '../models/Transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransctions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.month == weekDay.month &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          total += recentTransactions[i].cost;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(total);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': total
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransctions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransctions);
    return Card(
          elevation: 6,
          margin: EdgeInsets.all(15),
            child: Container(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransctions.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                    child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                  ),
                );
              }).toList(),
          ),
        ),
    );
  }
}
