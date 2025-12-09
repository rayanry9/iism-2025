import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iism_2025/firebase_options.dart';
import 'package:iism_2025/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/services/api_service.dart';
import 'package:iism_2025/services/auth.dart';
import 'package:iism_2025/services/notification.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  // if (dotenv.env['DEBUG'] == "TRUE") {
  //   UserCache().sports = [
  //     {"id": 7, "name": "Tennis", "staff": false, "type": 1}
  //   ];
  //   UserCache().assignedId = "2";
  //   UserCache().role = 2;
  // }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await configureAPIService();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  auth = AuthStatus();
  await auth.checkLoginState();
  await NotificationService.initialize();

  runApp(MyApp(auth: auth));
}

class MyApp extends StatelessWidget {
  final AuthStatus auth;

  const MyApp({super.key, required this.auth});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(auth: auth),
      theme: ThemeData(fontFamily: 'Optima Nova LT Pro'),
    );
  }
}
