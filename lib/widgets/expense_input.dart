import "package:flutter/material.dart";

class ExpenseInput extends StatefulWidget {
  @override
  State createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    amountController.dispose();
  }

  void _getDatePicker() {
    final now = DateTime.now();
    final last = DateTime(now.year + 1, now.month, now.day);
    showDatePicker(
        context: context, initialDate: now, firstDate: now, lastDate: last);
  }

  void _createExpense() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: nameController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Expense name")),
            keyboardType: TextInputType.text,
          ),
          TextField(
              controller: amountController,
              decoration: const InputDecoration(
                  prefixText: "\$ ", label: Text("Expense Amount")),
              keyboardType: TextInputType.number),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Escolha uma data"),
                    IconButton(
                        tooltip: "Escolha a data da despesa",
                        onPressed: _getDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
                ElevatedButton(
                    onPressed: _createExpense, child: const Text("Criar Gasto"))
              ],
            ),
          )
        ]));
  }
}
