import 'package:flutter/material.dart';
import 'package:fluttertest/Screen/attraction_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeData(),
      home: AttractionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
  ThemeData themeData (){
  return ThemeData(
    appBarTheme: const AppBarTheme(color: Colors.white),
    scaffoldBackgroundColor: Colors.grey[100],
  );
}
}


