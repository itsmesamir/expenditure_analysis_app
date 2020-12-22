import 'package:expenditure_analysis_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transaction.dart';
// import 'transactionUI.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTrans;
  TransactionList(this.transactions, this.removeTrans);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: transactions.isEmpty
            ? LayoutBuilder(
                builder: (contx, constr) {
                  return Column(
                    children: [
                      Text(
                        "No transaction added yet.",
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height: constr.maxHeight * 0.05,
                      ),
                      Container(
                        height: constr.maxHeight * 0.6,
                        child: Image.asset(
                          "assets/images/waiting.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  // return TransactionUI(
                  //   transaction: transactions[index],
                  // );

                  return TransactionItem(
                      key: ValueKey(transactions[index].id),
                      transaction: transactions[index],
                      removeTrans: removeTrans);
                },
              ),  
      ),
    );
  }
}
