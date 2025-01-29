import 'package:flutter/material.dart';
import 'package:my_entertainment/home.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    title: "My Entertainment",
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
