import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(
                '\u20B9${spendingAmount.toStringAsFixed(2)}',
              )),
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
            Container(
              height: constraints.maxHeight * 0.5,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                      heightFactor: spendingPercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 5),
                height: constraints.maxHeight * 0.15,
                child: Text(label))
          ],
        ),
      );
    });
  }
}
