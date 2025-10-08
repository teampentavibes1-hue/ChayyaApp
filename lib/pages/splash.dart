import 'package:chaya_team/pages/login.dart';
import 'package:flutter/material.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    // TODO: implement initState
    gotoLoginPage();
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
}
