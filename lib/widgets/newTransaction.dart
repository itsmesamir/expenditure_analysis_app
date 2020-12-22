import '../widgets/adpative_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrans;

  NewTransaction(this.addTrans);

  @override
  State<StatefulWidget> createState() {
    return NewTransactionState();
  }
}

class NewTransactionState extends State<NewTransaction> {
  final txtTitle = TextEditingController();
  final txtAmount = TextEditingController();
  DateTime chosenDate;
  void submitData() {
    if (txtAmount.text.isEmpty) {
      return;
    }
    final enteredTitle = txtTitle.text;
    final enteredAmount = double.parse(txtAmount.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || chosenDate == null) {
      return;
    }
    widget.addTrans(
      enteredTitle,
      enteredAmount,
      chosenDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datetime) {
      if (datetime == null) {
        return;
      }
      setState(() {
        chosenDate = datetime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          margin: EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                // onChanged: (value) => txtTitle = value,
                controller: txtTitle,
                onSubmitted: (value) {
                  return submitData();
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                ),
                controller: txtAmount,
                keyboardType: TextInputType.number,

                // onChanged: (val) {
                //   txtAmount = val;
                // },
                onSubmitted: (value) {
                  return submitData();
                },
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        chosenDate == null
                            ? 'No date chosen'
                            : DateFormat.MMMEd().format(chosenDate),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    AdaptiveFlatButton(
                      "Choose Date",
                      _presentDatePicker,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FlatButton(
                  onPressed: submitData,
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
