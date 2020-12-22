import 'package:expenditure_analysis_app/widgets/chart_bar.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTransactionList;
  Charts(this.recentTransactionList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalAmount = 0.0;
      for (var i = 0; i < recentTransactionList.length; i++) {
        if (recentTransactionList[i].transactionDate.day == weekDay.day &&
            recentTransactionList[i].transactionDate.month == weekDay.month &&
            recentTransactionList[i].transactionDate.year == weekDay.year) {
          totalAmount += recentTransactionList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((ee) {
              return ChartBar(
                ee['day'],
                ee['amount'],
                maxSpending == 0.0
                    ? 0.0
                    : (ee['amount'] as double) / maxSpending,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
