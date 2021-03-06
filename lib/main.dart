import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_ui/screens/home.dart';
import 'package:login_ui/screens/login.dart';
import 'package:login_ui/screens/signin.dart';
import 'package:login_ui/screens/splash.dart';
import 'package:login_ui/screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MainApp());
  });
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      routes: {
        'splash': (context) => SplashScreen(),
        'login': (context) => UserLogin(),
        'welcome': (context) => Welcome(),
        'signin': (context) => Signin(),
        'home': (context) => HomeScreen(),
      },
    );
  }
}
