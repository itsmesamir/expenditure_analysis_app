import 'dart:io';
import './widgets/charts.dart';
import './widgets/newTransaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'widgets/transactionList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //   [
    //     DeviceOrientation.portraitUp,
    //   ],
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expenditure App",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final List<Transaction> _abc = [
    Transaction(
      id: "0213",
      title: "Smartphone",
      amount: 2025,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: "9652",
      title: "Laptop",
      amount: 1015,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: "78452",
      title: "Umbrella",
      amount: 55,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: "8745",
      title: "Shoes",
      amount: 25,
      transactionDate: DateTime.now(),
    ),
    Transaction(
      id: "5656",
      title: "Shocks",
      amount: 15,
      transactionDate: DateTime.now(),
    ),
  ];

  bool _chartValue = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _abc.where((trans) {
      return trans.transactionDate
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransactions(String txtTitle, double txtAmount, DateTime dateTm) {
    final trans = Transaction(
      id: DateTime.now().toString(),
      title: txtTitle,
      amount: txtAmount,
      transactionDate: dateTm,
    );

    setState(() {
      _abc.add(trans);
    });
  }

  void addTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (contxt) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _abc.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Show chart",
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _chartValue,
              onChanged: (value) {
                setState(() {
                  _chartValue = value;
                });
              }),
        ],
      ),
      _chartValue
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.65,
              child: Charts(_recentTransactions),
            )
          : Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.83,
              padding: EdgeInsets.only(bottom: 30),
              child: TransactionList(this._abc, _removeTransaction),
            ),
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Charts(_recentTransactions),
      ),
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        padding: EdgeInsets.only(bottom: 30),
        child: TransactionList(this._abc, _removeTransaction),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Daily Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    addTransaction(context);
                  },
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Daily Expenses',
            ),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  addTransaction(context);
                },
              ),
            ],
          );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
              ),
            if (!_isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                addTransaction(context);
              },
              child: Icon(Icons.add),
              foregroundColor: Theme.of(context).primaryColorDark,
            ),
            floatingActionButtonLocation: Platform.isIOS
                ? Container()
                : FloatingActionButtonLocation.miniCenterFloat,
          );
  }
}
