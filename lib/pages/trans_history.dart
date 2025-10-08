import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const TransactionHistoryPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        centerTitle: true,
      ),
      body: transactions.isEmpty
          ? const Center(child: Text("No transactions yet"))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final txn = transactions[index];
                return ListTile(
                  leading: Icon(
                    txn["type"] == "Credit"
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: txn["type"] == "Credit" ? Colors.green : Colors.red,
                  ),
                  title: Text(
                    "${txn["type"]} ₹${txn["amount"].toStringAsFixed(2)}",
                    style: TextStyle(
                      color: txn["type"] == "Credit"
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("User: ${txn["user"]}"),
                  trailing: Text(
                    "${txn["date"].hour}:${txn["date"].minute.toString().padLeft(2, '0')}",
                  ),
                );
              },
            ),
    );
  }
}
