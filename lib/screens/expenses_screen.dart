import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/models/expense.dart';
import 'package:simple_expense_tracker/screens/new_expense.dart';
import 'package:simple_expense_tracker/screens/widgets/chart/chart.dart';
import 'package:simple_expense_tracker/screens/widgets/expense_item.dart';
import 'package:simple_expense_tracker/utils/app_layout.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Groceries",
        amount: 100.00,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Subscriptions",
        amount: 700.00,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "Gas",
        amount: 250.00,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: "Cinema",
        amount: 300.00,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addEditExpense(Expense expense) {
    setState(() {
      if (_registeredExpenses.any((element) => element.id == expense.id)) {
        _registeredExpenses[_registeredExpenses
            .indexWhere((element) => element.id == expense.id)] = expense;
      } else {
        _registeredExpenses.add(expense);
      }
    });
  }

  void _removeExpense(Expense expense) {
    var indexOfExpense = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted"),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(indexOfExpense, expense);
          });
        },
      ),
    ));
  }

  void _openAddExpenseOverlay(Expense? expenseToEdit) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewExpense(
          addExpense: _addEditExpense,
        );
      },
      isScrollControlled: true,
      useSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);

    Widget noContent = const Center(
      child: Text("No expense available"),
    );

    Widget mainContent = ListView.builder(
      itemCount: _registeredExpenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(_registeredExpenses[index]),
        confirmDismiss: (direction) async {
          return (direction == DismissDirection.endToStart);
        },
        secondaryBackground: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.delete),
            SizedBox(
              width: displayWidth * 0.08,
            )
          ],
        ),
        background: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text("eddqd"),
            SizedBox(
              width: displayWidth * 0.08,
            ),
            const Icon(Icons.edit),
          ],
        ),
        child: ExpenseItem(_registeredExpenses[index]),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            _removeExpense(_registeredExpenses[index]);
          } else {
            _openAddExpenseOverlay(_registeredExpenses[index]);
          }
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
        // backgroundColor: const Color(0xFF190048),
        titleTextStyle: const TextStyle(
          // color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              // color: Colors.white,
            ),
            onPressed: () {
              _openAddExpenseOverlay(null);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: displayHeight * 0.02,
          ),
          child: displayWidth < 600 ? Column(
            children: [
              SizedBox(
                height: displayHeight * 0.35,
                child: Chart(
                  recentExpenses: _registeredExpenses,
                ),
              ),
              SizedBox(
                height: displayHeight * 0.03,
              ),
              Expanded(
                // width: 500,
                // height: 500,
                child: _registeredExpenses.isEmpty ? noContent : mainContent,
              )
            ],
          ) : Row(
            children: [
              Expanded(
                child: Chart(
                  recentExpenses: _registeredExpenses,
                ),
              ),
              Expanded(
                // width: 500,
                // height: 500,
                child: _registeredExpenses.isEmpty ? noContent : mainContent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
