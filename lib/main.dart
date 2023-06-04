import 'package:flutter/material.dart';
import 'package:simple_expense_tracker/screens/expenses_screen.dart';
import 'package:simple_expense_tracker/utils/app_layout.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kColorSchemeDark = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final displayWidth = ;
    // final displayHeight = AppLayout.displayHeightWithoutAppBar(context);
    
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 14
          )
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kColorSchemeDark,
        appBarTheme: AppBarTheme(
          backgroundColor: kColorSchemeDark.onPrimaryContainer,
          foregroundColor: kColorSchemeDark.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorSchemeDark.onSecondaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorSchemeDark.primaryContainer,
            )
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorSchemeDark.onSecondaryContainer,
                fontSize: 14
            ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: kColorSchemeDark.onSecondaryContainer,
        ),
        inputDecorationTheme: ThemeData().inputDecorationTheme.copyWith(
          labelStyle: TextStyle(
            color: kColorSchemeDark.tertiaryContainer,
          ),
          counterStyle: TextStyle(
            color: kColorSchemeDark.tertiaryContainer,
          ),
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const ExpensesScreen(),
    );
  }
}