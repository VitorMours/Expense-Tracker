import 'package:expense_tracker/widgets/expense_input.dart';
import 'package:expense_tracker/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'models/expense.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State createState() => _ExpensePage();
}

class _ExpensePage extends State<ExpensePage> {
  List<Expense> expensesList = [
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

  void addExpense(Expense expense) {
    setState(() {
      expensesList.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.background,
        context: context,
        builder: (BuildContext context) {
          return ExpenseInput(onCreateExpense: addExpense);
        });
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
