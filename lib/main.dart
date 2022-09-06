import 'package:flutter/material.dart';
import './screen/home_screen.dart';
import './screen/movie_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/home-screen': (context) => const HomeScreen(),
        '/movie-detail': (context) => const MovieDetail(),
      },
    );
  }
}
