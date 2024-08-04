import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snow_login/screens/login_screen.dart';
import 'package:snow_login/screens/forgetpassword.dart'; // Ensure this path is correct
import 'package:snow_login/screens/verifyCodefp.dart'; // Adjust import to match file path
import 'package:snow_login/screens/newpassword.dart'; // Adjust import to match file path
import 'package:snow_login/screens/homepage.dart';
import 'package:snow_login/screens/reclamations.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/forgetpassword': (context) => const ForgetPasswordScreen(),
        '/verifyOTP': (context) => const VerifyCodefpScreen(), 
        '/changepwd': (context) => const NewPasswordScreen(),
        '/homepage': (context) => const HomePage(),
        '/Reclamations': (context) => const ReclamationsScreen(),


      },
    );
  }
}
