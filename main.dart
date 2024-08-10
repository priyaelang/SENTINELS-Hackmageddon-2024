import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_provider.dart'; // Import your AlertProvider
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlertProvider()), // Add AlertProvider
        // Add other providers here if needed
      ],
      child: MaterialApp(
        title: 'Crowd Management App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
            labelLarge: TextStyle(color: Colors.white70),
          ),
        ),
        home: LoginPage(),
        routes: {
          '/home': (context) => HomePage(username: ModalRoute.of(context)!.settings.arguments as String), // Pass username dynamically
          '/signup': (context) => SignupPage(),
        },
      ),
    );
  }
}
