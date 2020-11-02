import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screensUse/login.dart';

void main() async {
  // these 2 lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      title: '',
      home: Login(),
    );
  }
}
