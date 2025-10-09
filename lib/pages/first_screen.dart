import 'package:chaya_team/pages/login.dart';
import 'package:chaya_team/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(userName: "Test User", balance: 00.00),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userName;
  final double balance;

  const HomePage({super.key, required this.userName, required this.balance});

  void _onLogout(BuildContext context) {
    // Example action: show snackbar
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Logged out successfully!")));
    Navigator.of(
      // ignore: use_build_context_synchronously
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => LoginPage()));
    // TODO: Add navigation to login page or session clear here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              logOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User Name in Bold Red
            Text(
              userName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 12),

            // Balance Amount in Rupees
            Text(
              "Balance: ₹${balance.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 22, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  void logOut(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();
    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx1) => ScreenSplash()),
      (route) => false,
    );
  }
}
