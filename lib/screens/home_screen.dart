import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';
import 'add_expense_screen.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      title: 'Lunch',
      amount: 500,
      category: 'Food',
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      title: 'Bus fare',
      amount: 100,
      category: 'Travel',
      date: DateTime.now(),
    ),
    Expense(
      id: '3',
      title: 'Internet bill',
      amount: 2000,
      category: 'Bills',
      date: DateTime.now(),
    ),
  ];

  double get _total => _expenses.fold(0, (sum, e) => sum + e.amount);

  Future<void> _openAddScreen() async {
    final newExpense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
    );
    if (newExpense != null) {
      setState(() {
        _expenses.add(newExpense);
      });
    }
  }

  void _deleteExpense(String id) {
    setState(() {
      _expenses.removeWhere((e) => e.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthService().logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total spent', style: TextStyle(fontSize: 16)),
                  Text(
                    'Rs. ${_total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _expenses.isEmpty
                ? const Center(
                    child: Text('No expenses yet. Tap + to add one.'),
                  )
                : ListView.builder(
                    itemCount: _expenses.length,
                    itemBuilder: (context, index) {
                      final expense = _expenses[index];
                      return Dismissible(
                        key: Key(expense.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _deleteExpense(expense.id),
                        child: ExpenseTile(expense: expense),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddScreen,
        child: const Icon(Icons.add),
      ),
    );
  }
}
