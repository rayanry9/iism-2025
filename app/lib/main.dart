import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iism_2025/firebase_options.dart';
import 'package:iism_2025/router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/services/api_service.dart';
import 'package:iism_2025/services/auth.dart';
import 'package:iism_2025/services/notification.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:provider/provider.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final ApiService apiService = await ApiService.init();
  final AuthStatus auth = await AuthStatus.init(apiService: apiService);
  final NotificationService notificationService =
      await NotificationService.init(apiService);
  final UserViewModel user = await UserViewModel.init(apiService);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: apiService),
        ChangeNotifierProvider.value(value: auth),
        Provider.value(value: notificationService),
        ChangeNotifierProvider.value(value: user),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router(auth: context.read()),
      theme: ThemeData(fontFamily: 'Optima Nova LT Pro'),
    );
  }
}
