import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ippon/navigation/nav.dart';
import 'package:ippon/view/profile.dart';
import 'package:ippon/view/sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders([
    GoogleProvider(
        clientId:
            '547003028745-ub683e5cl74uiphefjj04b7ro9d3gseu.apps.googleusercontent.com'),
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  String get initialRoute {
    final user = FirebaseAuth.instance.currentUser;

    // return switch (user) {
    //   null => '/',
    //   User() => '/app',
    // };
    return '/';
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.green,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      initialRoute: initialRoute,
      routes: {
        '/': (context) {
          return const SignIn();
        },
        '/profile': (context) {
          return const Profile();
        },
        '/app': (context) {
          return const BottomBar();
        },
      },
      title: 'Ippon',
      debugShowCheckedModeBanner: false,
    );
  }
}
