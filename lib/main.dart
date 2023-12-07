import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import 'books/data/models/book_list.dart';
import 'books/pages/favorites.dart';
import 'books/pages/home.dart';
import 'books/pages/intropage.dart';
import 'books/themes/apptheme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookList(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
        PointerDeviceKind.trackpad,
      }),
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/home': (context) => const MyHome(),
        '/favorites': (context) => const FavoritesPage(),
      },
    );
  }
}
