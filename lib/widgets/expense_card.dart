import "package:flutter/material.dart";

import "../models/expense.dart";

class ExpenseCard extends StatelessWidget {
  ExpenseCard({super.key, required this.expense});

  Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 0.9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 50,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(expense.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("R\$${expense.amount.toStringAsFixed(2)}"),
                            Row(
                              children: [
                                Icon(itemCategory[expense.category]),
                                Text(" ${expense.formattedDate}"),
                              ],
                            )
                          ]),
                    )
                  ]),
            )));
  }
}
