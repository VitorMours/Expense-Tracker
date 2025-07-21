import "package:flutter/material.dart";

import "../models/expense.dart";
import "expense_card.dart";

class ExpenseList extends StatelessWidget {
  List<Expense> expenses;

  ExpenseList({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // Set an appropriate height
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => ExpenseCard(expense: expenses[index]),
      ),
    );
  }
}
