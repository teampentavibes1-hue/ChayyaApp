import 'package:chaya_team/pages/first_screen.dart';
import 'package:chaya_team/pages/home_admin.dart';
import 'package:chaya_team/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _userTYpe = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chaya App"),
        leading: const Icon(Icons.filter_vintage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-Mail'),
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid password!';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      checkLogin(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == 'sunils@ikm.in' && password == '123') {
      _userTYpe = 1; // Admin
      rootLogin(ctx);
    } else if (username == 'misha@ikm.in' && password == '123') {
      _userTYpe = 2; // Normal user
      rootLogin(ctx);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 175, 91, 76),
          content: Text(
            "Username and password do not match... ",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void rootLogin(BuildContext ctx) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Successfully logged in",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
      ),
    );

    final _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setBool(SAVE_KEY_NMAE, true);

    if (_userTYpe == 2) {
      USER_KEY_NMAE = 'Misha';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomePage(userName: USER_KEY_NMAE, balance: 122.00),
        ),
      );
    } else if (_userTYpe == 1) {
      USER_KEY_NMAE = 'Sunil S';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => const HomePageAdmin()),
      );
    }
  }
}
