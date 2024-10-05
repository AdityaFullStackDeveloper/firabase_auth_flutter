import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/screen/home_screen.dart';
import 'package:firebase_authen/screen/signUp_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    var auth = FirebaseAuth.instance.currentUser?.uid;
    _timer = Timer(const Duration(seconds: 3), () {
      if(auth != null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpScreen()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Image.asset('images/firebaseImage.jpg'),
      ),
    );
  }
}
