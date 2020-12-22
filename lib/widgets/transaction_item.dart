import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTrans,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTrans;

  @override
  _TransactionItemState createState() {
    return _TransactionItemState();
  }
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.amber,
      Colors.red,
      Colors.black,
      Colors.blue
    ];
    super.initState();
    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          foregroundColor: Colors.white,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text("\$${widget.transaction.amount}"),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.transactionDate),
        ),
        trailing: MediaQuery.of(context).size.width > 490
            ? FlatButton.icon(
                onPressed: () => widget.removeTrans(widget.transaction.id),
                icon: Icon(Icons.delete, color: Colors.deepOrange),
                label: Text("Delete"),
              )
            : IconButton(
                onPressed: () {
                  return widget.removeTrans(widget.transaction.id);
                },
                icon: Icon(Icons.delete, color: Colors.deepOrange),
              ),
      ),
    );
  }
}
