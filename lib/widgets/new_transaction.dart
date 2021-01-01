import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (this._amountController.text.isEmpty) return;

    final enteredTitle = this._titleController.text;
    final enteredAmount = double.parse(this._amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        this._selectedDate == null) {
      return;
    }

    this.widget.addNewTransaction(
          this._titleController.text,
          double.parse(this._amountController.text),
          this._selectedDate,
        );

    Navigator.of(this.context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: this.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        this._selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: this._titleController,
                onChanged: (String value) {
                  //this.titleInput = value;
                },
                onSubmitted: (_) {
                  this._submitData();
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: this._amountController,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  //this.amountInput = value;
                },
                onSubmitted: (_) {
                  this._submitData();
                },
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        this._selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(this._selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: this._presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: this._submitData,
                child: Text(
                  'Add Transaction',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
