import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String name;
  final double cost;
  final DateTime dateTime;

  Transaction({
     @required this.id,
     @required this.name,
     @required this.cost,
     @required this.dateTime,
  });
}
