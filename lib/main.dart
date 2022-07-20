import 'package:flutter/material.dart';
import 'package:re_learn/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:re_learn/screens/chart.dart';
import 'package:re_learn/screens/transaction_input.dart';
import 'package:re_learn/screens/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 're-Learn',
      theme: ThemeData(
        errorColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'EduSABeginner-SemiBold',
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'RopaSans',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  List<Transaction> userTransactions = [
    // Transaction(id: '01', title: 'Shoes', amount: 15.55, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(String titleTx, double amountTx, DateTime date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: titleTx,
        amount: amountTx,
        date: date);

    setState(() {
      userTransactions.add(newTx);
    });
  }

  void startAddNewTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: InputTransaction(addTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(onPressed: () => startAddNewTrans, icon: Icon(Icons.add))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.25,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.75,
                child: TransactionList(userTransactions, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTrans(context),
        child: Icon(
          Icons.add_circle,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
