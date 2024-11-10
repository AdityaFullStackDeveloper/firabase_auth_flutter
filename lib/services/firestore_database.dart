import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authen/screen/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/services/RealTIme_database.dart';
import 'package:flutter/material.dart';

class FireStoreDatabase extends StatefulWidget {
  const FireStoreDatabase({super.key});

  @override
  State<FireStoreDatabase> createState() => _FireStoreDatabaseState();
}

class _FireStoreDatabaseState extends State<FireStoreDatabase> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'FireStore Database',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  labelText: 'Name',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal))),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal))),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDataToFireStore,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 3),
              child: const Text('Add Data'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Text('View All Data'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 3),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RealtimeDatabase()),
                );
              },
              child: const Text('RealTimeDatabase'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, elevation: 3),
            ),
          ],
        ),
      ),
    );
  }

  void _addDataToFireStore() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (name.isNotEmpty && email.isNotEmpty && userId.isNotEmpty) {
      try {
        await _firebaseFireStore.collection('users').add({
          'id': userId,
          'userName': name,
          'userEmail': email,
        });

        _nameController.clear();
        _emailController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data added successfully')),
        );
      } catch (exception) {
        print("Error adding data: $exception");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add data')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name and email')),
      );
    }
  }
}
