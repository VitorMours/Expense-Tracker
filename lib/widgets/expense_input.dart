import "package:expense_tracker/models/expense.dart";
import "package:flutter/material.dart";
import "../expense_page.dart";

class ExpenseInput extends StatefulWidget {
  const ExpenseInput({super.key, required this.onCreateExpense});

  final Function(Expense) onCreateExpense;

  @override
  State createState() => _ExpenseInputState();
}

class _ExpenseInputState extends State<ExpenseInput> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  DateTime? datePicked;
  Category? _dropdownValue;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    amountController.dispose();
  }

  void addCreatedExpense() {
    Expense newExpense = Expense(
      name: nameController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      date: datePicked!,
      category: _dropdownValue!,
    );
    widget.onCreateExpense(newExpense);
    nameController.clear();
    amountController.clear();
    datePicked = null;
    _dropdownValue = null;
    Navigator.of(context).pop();
  }

  Future<void> _getDatePicker() async {
    final now = DateTime.now();
    final last = DateTime(now.year + 1, now.month, now.day);

    datePicked = await showDatePicker(
        context: context, initialDate: now, firstDate: now, lastDate: last);

    setState(() {
      datePicked = datePicked;
    });
  }

  void _createExpense() {
    if (nameController.text.isEmpty ||
        amountController.text.isEmpty ||
        datePicked == null ||
        _dropdownValue == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                    "Tiveram valores que foram preenchidos incorretamente"),
                content: const Text(
                    "Por favor, corrija os valores e preencha eles de maneira correta para poder registrar o gasto de maneira correta igualmente."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"))
                ],
              ));
      return;
    }
    addCreatedExpense();
  }

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
                    Text(datePicked == null
                        ? "Escolha uma data"
                        : DateFormatter.format(datePicked!)),
                    IconButton(
                        tooltip: "Escolha a data da despesa",
                        onPressed: _getDatePicker,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
                DropdownButton(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    value: _dropdownValue,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == null) {
                          return;
                        }
                        _dropdownValue = value;
                      });
                    }),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: _createExpense, child: const Text("Criar Gasto")),
            ],
          )
        ]));
  }
}
