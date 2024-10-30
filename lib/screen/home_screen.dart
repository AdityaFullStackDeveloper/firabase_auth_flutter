import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/screen/otp_verification.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationID = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'Number...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => getOtp(), child: const Text('Send Otp')),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Otp',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => verifyOtp(), child: const Text('Verify Otp'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getOtp() async {
    var userPhoneNumber = "+91${phoneController.text.trim()}";
    await _auth.verifyPhoneNumber(
      phoneNumber: userPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${exception.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          verificationID = verificationId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP has been sent!')),
        );
      },
      codeAutoRetrievalTimeout: (String verificationIDCode) {
        setState(() {
          verificationID = verificationIDCode;
        });
      },
      timeout: const Duration(seconds: 60),
    );
  }

  void verifyOtp() {
    var smsCode = otpController.text.toString().trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationID, smsCode: smsCode
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpVerification()));
  }
}

