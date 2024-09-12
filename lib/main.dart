import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_test_app/screens/home_screen.dart';
import 'package:login_test_app/screens/login_screen.dart';
import 'package:login_test_app/screens/register_screen.dart';

import 'firebase_options.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:  LoginScreen().id,
      routes: {
        LoginScreen().id: (context) =>   LoginScreen(),
        RegisterScreen().id: (context) =>  RegisterScreen(),
      },
    );
  }
}