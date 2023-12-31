import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mytok/firebase_api.dart';
import 'package:mytok/screens/home_screen.dart';
import 'package:mytok/screens/register_screen.dart';
import 'package:mytok/screens/welcome_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized.
  await Hive.initFlutter();
  await Hive.openBox('users');
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var users = Hive.box('users');
    var user = users.get("name");
    bool isReg = false;
    if(user != null){
      isReg = true;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyTok',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: isReg ? HomePage() : WelcomeScreen(),
    );
  }


}
