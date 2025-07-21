import "package:flutter/material.dart";
import "package:uuid/uuid.dart";
import "package:uuid/v4.dart";
import "package:intl/intl.dart";

// ignore: constant_identifier_names
final DateFormatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { travel, leisure, food, fun }

const itemCategory = {
  Category.food: Icons.lunch_dining,
  Category.fun: Icons.party_mode,
  Category.leisure: Icons.movie,
  Category.travel: Icons.airplane_ticket
};

class Expense {
  final String id;

  Expense(
      {required this.name,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return DateFormatter.format(date);
  }
}
