import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iism_2025/firebase_options.dart';
import 'package:iism_2025/router.dart';
import 'package:iism_2025/screens/logindetails.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/services/user_cache.dart';

Future<void> main() async {
  setupDio();
  await dotenv.load(fileName: ".env");
  // if (dotenv.env['DEBUG'] == "TRUE") {
  //   UserCache().sports = [
  //     {"id": 7, "name": "Tennis", "staff": false, "type": 1}
  //   ];
  //   UserCache().assignedId = "2";
  //   UserCache().role = 2;
  // }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
