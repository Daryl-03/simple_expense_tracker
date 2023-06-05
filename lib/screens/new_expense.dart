import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:simple_expense_tracker/models/expense.dart';
import 'package:simple_expense_tracker/utils/app_layout.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    required this.addExpense,
    Key? key,
  }) : super(key: key);

  final Function addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    final now = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty ||
        (enteredAmount == null || enteredAmount <= 0) ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Invalid input"),
              content: const Text("Please make sure the inputs are correct"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("close"),
                )
              ],
            );
          });
      return;
    }
    Expense newExpense = Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory);
    widget.addExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutStatusBar(context);

    Widget titleTextField = TextField(
      controller: _titleController,
      decoration: const InputDecoration(
        labelText: "Title",
      ),
      maxLength: 50,
    );

    Widget amountTextField = Expanded(
      child: TextField(
        controller: _amountController,
        decoration: const InputDecoration(
          labelText: "Amount",
          prefixText: "\$ ",
        ),
        keyboardType: TextInputType.number,
      ),
    );

    Widget datePicker = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_selectedDate != null
              ? formatter.format(_selectedDate!)
              : "No selected date"),
          IconButton(
            onPressed: _presentDatePicker,
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );

    Widget categoryDropdownMenu = DropdownButton(
      items: Category.values
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name.toUpperCase()),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          if (value == null) {
            return;
          }
          _selectedCategory = value;
        });
      },
      value: _selectedCategory,
    );
    print(displayWidth);

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: displayHeight * 0.02,
            left: displayWidth * 0.05,
            right: displayWidth * 0.05,
            bottom: keyboardSpace + displayHeight * 0.02,
          ),
          child: Column(
            children: [
              if (displayWidth > 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: titleTextField,
                    ),
                    SizedBox(
                      width: displayWidth * 0.03,
                    ),
                    amountTextField,
                  ],
                )
              else
                titleTextField,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (displayWidth < 600) ? amountTextField : categoryDropdownMenu,
                  SizedBox(
                    width: displayWidth * 0.02,
                  ),
                  datePicker
                ],
              ),
              SizedBox(
                height: displayHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (displayWidth < 600) categoryDropdownMenu,
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  SizedBox(
                    width: displayWidth * 0.1,
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text("Add Expense"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
