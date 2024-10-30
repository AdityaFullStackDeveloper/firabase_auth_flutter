import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_authen/screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Fluttertoast.showToast(msg: "Sign Up Successful");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (error) {
      stdout.write("Sign Up Error: $error");
      Fluttertoast.showToast(msg: "Error: $error");
    }
  }

  Future<void> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user?.displayName);

      await FirebaseAuth.instance.signInWithCredential(credential);
      Fluttertoast.showToast(msg: "Google Sign-In Successful");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: $error");
    }
  }

  Future<void> facebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);

        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        Fluttertoast.showToast(msg: "Facebook Sign-In Successful");

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Fluttertoast.showToast(msg: "Facebook Login Failed: ${result.message}");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Facebook Sign-In Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('SignUp Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp(_emailController.text, _passwordController.text);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.8, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              SignInButton(
                Buttons.google,
                text: "Sign Up with Google",
                onPressed: googleSignIn,
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              SignInButton(
                Buttons.facebook,
                text: "Sign Up with Facebook",
                onPressed: facebookSignIn,
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
