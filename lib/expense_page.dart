import 'package:expense_tracker/widgets/expense_graph.dart';
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
  List<Expense> expensesList = [];

  void addExpense(Expense expense) {
    setState(() {
      expensesList.add(expense);
    });
  }
  void undoDeleteExpense(Expense expense) {
    setState(() {
      expensesList.add(expense);
    });
  }

  void _deleteExpense(Expense expense, int index) {
    setState(() {
      expensesList.remove(expensesList[index]);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          undoDeleteExpense(expense);
        },
      ),
    ));
  }


  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
          ExpenseGraph(expenses: expensesList),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
                child: Text("Lista de Despesas",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
          ),
          ExpenseList(expenses: expensesList, deleteExpenseFunction: _deleteExpense )
        ],
      ),
    );
  }
}
