import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationId = '';

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
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () => getOtp(), child: const Text('Send Otp')),
              const SizedBox(height: 20,),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Otp',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () => verifyOtp, child: const Text('Verify Otp'))
            ],
          ),
        ),
      ),
    );
  }

  void getOtp() async {
    String userPhoneNumber = '+91${phoneController.text.trim()}';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: userPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException exception) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${exception.message}')),
        );
      },
      codeSent: (String verificationID, int? resendToken) {
        setState(() {
          verificationId = verificationID;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP has been sent!')),
        );
      },
      codeAutoRetrievalTimeout: (String verificationIDCode) {
        setState(() {
          verificationId = verificationIDCode;
        });
      },
      timeout: const Duration(seconds: 60),
    );
  }

  void verifyOtp() async {
    String otp = otpController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone Number Verified success')),
      );
    } catch (exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $exception')),
      );
    }
  }

}



