import 'dart:async';

import 'package:barber_shop/Provider/provider.dart';
import 'package:barber_shop/features/reservation/screens/reservation_screen.dart';
import 'package:barber_shop/screens/home_screen.dart';
import 'package:barber_shop/screens/login_screen.dart';
import 'package:barber_shop/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// Initialize Firebase and run the app
Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter's binding is initialized
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final ThemeData theme =
      ThemeData(primaryColor: Color.fromARGB(255, 15, 61, 226));

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child:
          Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return MaterialApp(
            routes: {
              '/home': (context) => const HomeScreen(),
              '/logout': (context) => const LoginScreen(),
              '/reservation': (context) => const ReservationScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
            debugShowCheckedModeBanner: false,
            themeMode: notifier.isdark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: notifier.darkTheme,
            theme: theme,
            home: LoginScreen()
            //onst HomeScreen(),
            );
      }),
    );
  }
}
