import 'package:crescoo_seller/provider/auth_provider.dart';
import 'package:crescoo_seller/screens/Details.dart';
import 'package:crescoo_seller/screens/NavigationBar/add.dart';
import 'package:crescoo_seller/screens/NavigationBar/pitch.dart';
import 'package:crescoo_seller/screens/NavigationBar/profile.dart';
import 'package:crescoo_seller/screens/SplashScreen.dart';
import 'package:crescoo_seller/widgets/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(), // Initialize your AuthProvider
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "poppins",
      ),
      home: SplashScreen(),
    );
  }
}



