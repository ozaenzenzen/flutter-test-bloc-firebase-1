import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_bloc_1/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
