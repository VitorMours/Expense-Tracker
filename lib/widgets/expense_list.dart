import "package:flutter/material.dart";

import "../models/expense.dart";
import "expense_card.dart";

class ExpenseList extends StatefulWidget {
  List<Expense> expenses;

  ExpenseList({super.key, required this.expenses});

  @override
  State createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  void undoDeleteExpense(Expense expense) {
    setState(() {
      widget.expenses.add(expense);
    });
  }

  void onDeleteExpense(Expense expense, int index) {
    widget.expenses.remove(widget.expenses[index]);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Set an appropriate height
      child: ListView.builder(
        itemCount: widget.expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          key: ValueKey(widget.expenses[index]),
          onDismissed: (direction) {
            onDeleteExpense(widget.expenses[index], index);
          },
          child: ExpenseCard(expense: widget.expenses[index]),
        ),
      ),
    );
  }
}
