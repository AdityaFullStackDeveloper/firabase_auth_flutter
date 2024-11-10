import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authen/screen/realTime_database_userProfile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_authen/screen/profile_page.dart';

class RealtimeDatabase extends StatefulWidget {
  const RealtimeDatabase({super.key});

  @override
  State<RealtimeDatabase> createState() => _RealtimeDatabaseState();
}

class _RealtimeDatabaseState extends State<RealtimeDatabase> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final DatabaseReference _firebaseDataBase =
      FirebaseDatabase.instance.ref().child('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'RealTime Database',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nameController,
              cursorColor: Colors.teal,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.teal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _emailController,
              cursorColor: Colors.teal,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.teal),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDataToRealtimeDatabase,
              child: const Text('Add Data'),
              style: ElevatedButton.styleFrom(
                 foregroundColor: Colors.black, backgroundColor: Colors.white, elevation: 3),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          const RealtimeDatabaseUserprofile()),
                );
              },
              child: const Text('View All Data'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,backgroundColor: Colors.white, elevation: 3),
            ),
          ],
        ),
      ),
    );
  }

  void _addDataToRealtimeDatabase() async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (name.isNotEmpty && email.isNotEmpty && userId.isNotEmpty) {
      try {
        await _firebaseDataBase.push().set({
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
