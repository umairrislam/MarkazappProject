import 'package:flutter/material.dart';




import 'package:markazapp/Screens/navigationBarscreen.dart';
import 'package:markazapp/Signinsignupscreens/Signin_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool('isLogin') ?? false;

    Timer(const Duration(seconds: 5), () {
      if (isLogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationBarScreen ()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       
        child: Image.network(
          'https://crushlogo.com/files/preview/960x960/11683374716j9czbu9c637izxy5pwulgeipulrcvvx4nwih6qnrrugn1gzyqhdzoxwi0s3fbyu8ecujzoc6k6aesswp8kfjotyzgfqzdogrwwjm.png', // Replace with the actual image path
          width: 200.0,
          height: 200.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
