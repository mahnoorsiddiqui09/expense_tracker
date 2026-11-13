import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({super.key, required this.expense});

  IconData _iconFor(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;
      case 'Travel':
        return Icons.directions_bus;
      case 'Bills':
        return Icons.receipt_long;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Health':
        return Icons.favorite;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = expense.date;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Icon(_iconFor(expense.category))),
        title: Text(expense.title),
        subtitle: Text('${expense.category} • ${d.day}/${d.month}/${d.year}'),
        trailing: Text(
          'Rs. ${expense.amount.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
