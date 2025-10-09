import 'package:chaya_team/pages/first_screen.dart';
import 'package:chaya_team/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SAVE_KEY_NMAE = "UserLoggedIn";
var USER_KEY_NMAE = "UserName";

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/immages/chay3.jpeg', height: 900),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLoginPage() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(
      // ignore: use_build_context_synchronously
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => LoginPage()));
  }

  Future<void> gotoHomePage() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => HomePage(userName: USER_KEY_NMAE, balance: 122.00),
      ),
    );
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedPrefs.getBool(SAVE_KEY_NMAE);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      gotoLoginPage();
    } else {
      gotoHomePage();
    }
  }
}
