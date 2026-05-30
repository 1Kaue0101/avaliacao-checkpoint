import 'package:flutter/material.dart';
import 'package:checkpoint_final/src/screens/initial_screen.dart';
import 'package:checkpoint_final/src/screens/cart_screen.dart';
import 'package:checkpoint_final/src/screens/login_screen.dart';
import 'package:checkpoint_final/src/widgets/custom_app_bar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UseDev',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: UseDevColors.purple),
        scaffoldBackgroundColor: UseDevColors.lightBg,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: UseDevColors.dark,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const InitialScreen(),
      routes: {
        '/cart': (context) => const CartScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
