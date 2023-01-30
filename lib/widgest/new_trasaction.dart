import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTrasaction extends StatefulWidget {
  final Function addTx;

  NewTrasaction(this.addTx);

  @override
  State<NewTrasaction> createState() => _NewTrasactionState();
}

class _NewTrasactionState extends State<NewTrasaction> {
  final _titleController = TextEditingController();
  DateTime _selectedDate;
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty){
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
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
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),

            // onChanged: (value) {
            //   // titleInput = value;
            // },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount '),
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitData(),
            // onChanged: (value) {
            //   // amountInput = value;
            // },
          ),
          Container(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date is Chosen'
                      : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}'),
                ),
                FlatButton(
                  onPressed: _presentDatePicker,
                  child: Text('Choose Date ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: _submitData,
            child: Text('Add Trasaction'),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
          ),
        ]),
      ),
    );
  }
}
