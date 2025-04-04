import 'package:flutter/material.dart';
import 'entry_page.dart'; // import your entry page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EntryPage(), // this is where you set it!
    );
  }
}
