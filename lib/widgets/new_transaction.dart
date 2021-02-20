import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    DateTime enteredDate = _selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      print("something is not right");
      print("title : ${enteredTitle}");
      print("amount : ${enteredAmount}");
      print("Date : ${enteredDate}");
      return;
    }

    widget.addTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
     showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            //
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Platform.isIOS ? CupertinoTextField(
                  placeholder: 'Title',
                  onSubmitted: (_) => _submitData(),
                  controller: _titleController,
                ) : TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  onSubmitted: (_) => _submitData(),
                  controller: _titleController,
                ),
                Platform.isIOS ? CupertinoTextField(
                  placeholder: 'Amount',
                  onSubmitted: (_) => _submitData(),
                  controller: _amountController,
                    keyboardType: TextInputType.number,
                ) : TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                  controller: _amountController,
                ),
                //date picker
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      //text has chosen date
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No Date Chosen'
                            : DateFormat().add_yMMMd().format(_selectedDate)),
                      ),
                      AdaptiveFlatButton('Choose date', _presentDatePicker, context , false),
                    ],
                  ),
                ),
                AdaptiveFlatButton('Add Transaction', _submitData, context , true),
              ],
            ),
          )),
    );
  }
}
