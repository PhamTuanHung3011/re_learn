import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTransaction extends StatefulWidget {
  late final Function? addTrans;

  InputTransaction(this.addTrans);

  @override
  State<InputTransaction> createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  final titleTx = TextEditingController();
  final amountTx = TextEditingController();
  DateTime? selectedDate;



  void submitData() {
    if(amountTx.text.isEmpty) {
      return;
    }
    final choiceTitle = titleTx.text;
    final choiceAmount = double.parse(amountTx.text);
    if (choiceAmount <= 0 || choiceTitle.isEmpty || selectedDate == null) {
      return;
    }

    widget.addTrans!(choiceTitle, choiceAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
              2022,
            ),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: amountTx,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: titleTx,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => submitData,
            ),
            Container(
              height: 70.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    selectedDate == null
                        ? 'No date choice!'
                        : 'Picked date: ${DateFormat.yMd().format(selectedDate!)}' ,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Choose a Date',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(onPressed: submitData, child: Text('Adding'))
          ],
        ),
      ),
    );
  }
}
