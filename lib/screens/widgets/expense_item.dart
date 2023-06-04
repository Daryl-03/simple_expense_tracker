import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/models/expense.dart';
import 'package:simple_expense_tracker/utils/app_layout.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: displayWidth * 0.03,
        vertical: displayHeight * 0.01
      ),
      // color: const Color(0xFFDDCDF6),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: displayWidth * 0.05,
          vertical: displayHeight * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: displayHeight * 0.01,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "\$${expense.amount.toString()}"
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(
                      width: displayWidth * 0.02,
                    ),
                    Text(
                        expense.formattedDate
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
