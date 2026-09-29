import 'package:flutter/material.dart';
import 'tugas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Modul 3',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const AddTransactionScreen(),
    );
  }
}