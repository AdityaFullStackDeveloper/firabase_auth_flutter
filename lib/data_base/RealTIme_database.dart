import 'package:flutter/material.dart';

class RealtimeDatabase extends StatefulWidget {
  const RealtimeDatabase({super.key});

  @override
  State<RealtimeDatabase> createState() => _RealtimeDatabaseState();
}

class _RealtimeDatabaseState extends State<RealtimeDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RealTime Database',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
