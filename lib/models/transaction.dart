import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime transactionDate;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.transactionDate,
  });
}

List<Transaction> getFeeds() {
  List<Transaction> myList = [];
  Transaction transaction = Transaction(
    id: "0213",
    title: "Smartphone",
    amount: 2025,
    transactionDate: DateTime.now(),
  );
  Transaction transaction22 = Transaction(
    id: "9652",
    title: "Laptop",
    amount: 1015,
    transactionDate: DateTime.now(),
  );
  Transaction transaction1 = Transaction(
    id: "78452",
    title: "Umbrella",
    amount: 55,
    transactionDate: DateTime.now(),
  );
  Transaction transaction2 = Transaction(
    id: "8745",
    title: "Shoes",
    amount: 25,
    transactionDate: DateTime.now(),
  );
  Transaction transaction3 = Transaction(
    id: "5656",
    title: "Shocks",
    amount: 15,
    transactionDate: DateTime.now(),
  );

  myList.add(transaction);
  myList.add(transaction22);
  myList.add(transaction1);
  myList.add(transaction3);
  myList.add(transaction2);

  return myList;
}
