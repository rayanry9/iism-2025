import 'package:flutter/material.dart';
import 'package:iism_2025/router.dart';
import 'package:iism_2025/screens/logindetails.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async{
  setupDio();
   await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(fontFamily: 'Optima Nova LT Pro'),
    );
  }
}
