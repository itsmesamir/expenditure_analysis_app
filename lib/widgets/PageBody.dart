// import 'dart:io';

// import 'package:expenditure_analysis_app/models/transaction.dart';
// import 'package:expenditure_analysis_app/widgets/newTransaction.dart';
// import 'package:expenditure_analysis_app/widgets/transactionList.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'charts.dart';

// class PageBody1 extends StatefulWidget {
//   @override
//   _PageBodyState createState() => _PageBodyState();
// }

// class _PageBodyState extends State<PageBody1> {
//   final List<Transaction> _abc = [
//     Transaction(
//       id: "0213",
//       title: "Smartphone",
//       amount: 2025,
//       transactionDate: DateTime.now(),
//     ),
//     Transaction(
//       id: "9652",
//       title: "Laptop",
//       amount: 1015,
//       transactionDate: DateTime.now(),
//     ),
//     Transaction(
//       id: "78452",
//       title: "Umbrella",
//       amount: 55,
//       transactionDate: DateTime.now(),
//     ),
//     Transaction(
//       id: "8745",
//       title: "Shoes",
//       amount: 25,
//       transactionDate: DateTime.now(),
//     ),
//     Transaction(
//       id: "5656",
//       title: "Shocks",
//       amount: 15,
//       transactionDate: DateTime.now(),
//     ),
//   ];
//   bool _chartValue = false;
//   List<Transaction> get _recentTransactions {
//     return _abc.where((trans) {
//       return trans.transactionDate
//           .isAfter(DateTime.now().subtract(Duration(days: 7)));
//     }).toList();
//   }

//   void _addTransactions(String txtTitle, double txtAmount, DateTime dateTm) {
//     final trans = Transaction(
//       id: DateTime.now().toString(),
//       title: txtTitle,
//       amount: txtAmount,
//       transactionDate: dateTm,
//     );

//     setState(() {
//       _abc.add(trans);
//     });
//   }

//   void _removeTransaction(String id) {
//     setState(() {
//       _abc.removeWhere((tx) {
//         return tx.id == id;
//       });
//     });
//   }

//   void addTransaction(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (contxt) {
//         return GestureDetector(
//           onTap: () {},
//           child: NewTransaction(_addTransactions),
//           behavior: HitTestBehavior.opaque,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final _isLandscape = mediaQuery.orientation == Orientation.landscape;
//     final PreferredSizeWidget appBar = Platform.isIOS
//         ? CupertinoNavigationBar(
//             middle: Text(
//               'Daily Expenses',
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 GestureDetector(
//                   child: Icon(CupertinoIcons.add),
//                   onTap: () {
//                     addTransaction(context);
//                   },
//                 ),
//               ],
//             ),
//           )
//         : AppBar(
//             title: Text(
//               'Daily Expenses',
//             ),
//             backgroundColor: Theme.of(context).primaryColor,
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {
//                   addTransaction(context);
//                 },
//               ),
//             ],
//           );
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         if (_isLandscape)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Show chart",
//                 style: Theme.of(context).textTheme.title,
//               ),
//               Switch.adaptive(
//                   activeColor: Theme.of(context).accentColor,
//                   value: _chartValue,
//                   onChanged: (value) {
//                     setState(() {
//                       _chartValue = value;
//                     });
//                   }),
//             ],
//           ),
//         if (!_isLandscape)
//           Container(
//             height: (mediaQuery.size.height -
//                     appBar.preferredSize.height -
//                     mediaQuery.padding.top) *
//                 0.3,
//             child: Charts(_recentTransactions),
//           ),
//         if (!_isLandscape)
//           Container(
//             height: (mediaQuery.size.height -
//                     appBar.preferredSize.height -
//                     mediaQuery.padding.top) *
//                 0.7,
//             padding: EdgeInsets.only(bottom: 30),
//             child: TransactionList(this._abc, _removeTransaction),
//           ),
//         if (_isLandscape)
//           _chartValue
//               ? Container(
//                   height: (mediaQuery.size.height -
//                           appBar.preferredSize.height -
//                           mediaQuery.padding.top) *
//                       0.65,
//                   child: Charts(_recentTransactions),
//                 )
//               : Container(
//                   height: (mediaQuery.size.height -
//                           appBar.preferredSize.height -
//                           mediaQuery.padding.top) *
//                       0.83,
//                   padding: EdgeInsets.only(bottom: 30),
//                   child: TransactionList(this._abc, _removeTransaction),
//                 ),
//       ],
//     );
//   }
// }
