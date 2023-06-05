import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/models/expense.dart';
import 'package:simple_expense_tracker/screens/widgets/chart/chart_bar.dart';
import 'package:simple_expense_tracker/utils/app_layout.dart';
import 'package:logger/logger.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
    required this.recentExpenses,
  }) : super(key: key);

  final List<Expense> recentExpenses;

  List<ExpenseBucket> get expenseBuckets{
    List<ExpenseBucket> buckets = [];
     for(var category in Category.values){
       buckets.add(
           ExpenseBucket.forCategory(recentExpenses, category)
       );
     }
      return buckets;
  }

  double get maxAmount{
    return expenseBuckets.fold(0.0, (previousValue, element) => previousValue > element.totalAmount ? previousValue : element.totalAmount);
  }

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final displayWidth = AppLayout.displayWidth(context);
    final displayHeight = AppLayout.displayHeightWithoutAppBar(context);
    final theme = Theme.of(context);


    return Container(
      // width: displayWidth * 0.9,
      margin: EdgeInsets.symmetric(
        horizontal: displayWidth * 0.02,
        vertical: displayHeight * 0.02,
      ),
      height: displayHeight > 600
          ? displayHeight * 0.4
          : displayHeight * 0.7,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            // theme.colorScheme.inversePrimary.withOpacity(0.2),
            // theme.colorScheme.inversePrimary.withOpacity(0.5),
            theme.colorScheme.inversePrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: theme.colorScheme.primary.withOpacity(0.5),
        //     blurRadius: 10,
        //     offset: Offset(
        //       displayWidth * 0.01,
        //       displayHeight * 0.01,
        //     ),
        //   ),
        // ],
        // color: theme.colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(
          displayWidth * 0.02,
        ),
      ),
      // child: Center(child: Text("Chart")),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: displayHeight * 0.01,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var bucket in widget.expenseBuckets)
                  Column(
                    children: [
                      // Container(
                      //   color: Colors.blue,
                      //   child: Text("cd"),
                      // ),
                      SizedBox(
                        width: constraints.maxWidth * 0.15,
                        height: constraints.maxHeight * 0.85,
                        child: ChartBar(
                          fill: bucket.totalAmount / widget.maxAmount,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.03,
                      ),
                      Icon(
                        categoryIcons[bucket.category],
                        color: theme.colorScheme.onPrimaryContainer,
                      )
                    ],
                  ),
              ],
            );
          }
        ),
      ),
    );
  }
}
