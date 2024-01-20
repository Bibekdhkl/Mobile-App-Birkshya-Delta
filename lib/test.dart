import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    _storeData();
  }

  Future<void> _storeData() async {
    DatabaseReference ref = database.ref().child('message');
    await ref.set('Hello Arjun');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
