import "package:flutter/material.dart";

import "../models/expense.dart";
import "expense_card.dart";

class ExpenseList extends StatefulWidget {
  List<Expense> expenses;
  Function deleteExpenseFunction;

  ExpenseList({super.key, required this.expenses, required this.deleteExpenseFunction});

  @override
  State createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            widget.deleteExpenseFunction(widget.expenses[index], index);
          },
          child: ExpenseCard(expense: widget.expenses[index]),
        ),
      ),
    );
  }
}
