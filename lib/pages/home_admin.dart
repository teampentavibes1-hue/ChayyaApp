import 'package:chaya_team/pages/splash.dart';
import 'package:chaya_team/pages/trans_history.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------- HOME PAGE ADMIN -----------------
class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  // List of users with balances
  final List<Map<String, dynamic>> users = [
    {"name": "Misha", "balance": 120.0},
    {"name": "Priya", "balance": 200.0},
    {"name": "Sreeraj", "balance": -50.0},
    {"name": "Ashish", "balance": 80.0},
    {"name": "Raji", "balance": 500.0},
    {"name": "Rekha", "balance": 300.0},
    {"name": "Jeeja", "balance": 100.0},
  ];

  // Transaction history
  final List<Map<String, dynamic>> transactions = [];

  // Update balance & add to transaction list
  void _updateBalance(int index, double amount, bool isCredit) {
    setState(() {
      if (isCredit) {
        users[index]["balance"] += amount;
        transactions.add({
          "user": users[index]["name"],
          "type": "Credit",
          "amount": amount,
          "date": DateTime.now(),
        });
      } else {
        users[index]["balance"] -= amount;
        transactions.add({
          "user": users[index]["name"],
          "type": "Debit",
          "amount": amount,
          "date": DateTime.now(),
        });
      }
    });
  }

  // Show dialog to enter amount
  void _showAmountDialog(int index, bool isCredit) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isCredit ? "Credit Amount" : "Debit Amount"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter amount"),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(ctx),
          ),
          ElevatedButton(
            child: const Text("OK"),
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                _updateBalance(index, amount, isCredit);
              }
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  // Open Transaction History Page
  void _openHistoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TransactionHistoryPage(transactions: transactions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: "Back",
          onPressed: () {
            gotoSplash(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "View Transaction History",
            onPressed: _openHistoryPage,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (ctx, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                user["name"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Balance: ₹${user["balance"].toStringAsFixed(2)}",
                style: TextStyle(
                  color: user["balance"] < 0 ? Colors.red : Colors.black,
                ),
              ),
              trailing: Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => _showAmountDialog(index, true),
                    child: const Text("Credit"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () => _showAmountDialog(index, false),
                    child: const Text("Debit"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void gotoSplash(BuildContext ctx) async {
    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx1) => ScreenSplash()),
      (route) => false,
    );
  }
}
