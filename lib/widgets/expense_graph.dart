import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseGraph extends StatefulWidget {
  ExpenseGraph({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<ExpenseGraph> createState() => _ExpenseGraphState();
}

class _ExpenseGraphState extends State<ExpenseGraph> {
  SideTitles getBottomTitles() {
    const types = ["Food", "Travel", "Leisure", "Fun"];
    return SideTitles(
      showTitles: true,
      getTitlesWidget: (value, meta) {
        return Text(types[value.toInt()], style: const TextStyle(fontSize: 12));
      },
    );
  }

  List<BarChartGroupData> generateBarGroups(Map<Category, double> totals) {
    final List<Category> orderedCategories = [
      Category.food,
      Category.travel,
      Category.leisure,
      Category.fun,
    ];

    return List.generate(orderedCategories.length, (index) {
      final category = orderedCategories[index];
      final total = totals[category]!;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: total,
            color: Colors.purple,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<Category, double> totals = {
      Category.food: 0,
      Category.travel: 0,
      Category.leisure: 0,
      Category.fun: 0,
    };

    for (final expense in widget.expenses) {
      totals[expense.category] = totals[expense.category]! + expense.amount;
    }

    final maxYValue = totals.values.fold(0.0, (prev, val) => val > prev ? val : prev);

    return Container(
      height: 200, // altura máxima visual do gráfico
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BarChart(
        duration: Duration(milliseconds: 200 ),
        BarChartData(
          maxY: maxYValue == 0 ? 100 : maxYValue, // ✅ altura proporcional
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  'R\$ ${rod.toY.toStringAsFixed(2)}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: getBottomTitles()),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: generateBarGroups(totals),
          baselineY: 0,
          minY: 0,
        ),
      ),
    );
  }
}