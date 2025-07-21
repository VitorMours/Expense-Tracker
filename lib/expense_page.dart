import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'models/expense.dart';

class ExpensePage extends StatefulWidget {
  @override
  State createState() => _ExpensePage();
}

class _ExpensePage extends State<ExpensePage> {
  final List<Expense> expensesList = [
    Expense(
      name: "Ferias",
      amount: 12,
      date: DateTime.now(),
      category: Category.fun,
    ),
    Expense(
      name: "Forneria",
      amount: 36,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      name: "Gasolina",
      amount: 42.58,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Text("Showing the modal bottom sheet"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker"), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _openAddExpenseOverlay,
        )
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("Grafico das coisas"),
          ExpenseList(expenses: expensesList)
        ],
      ),
    );
  }
}
