import 'package:flutter/material.dart';
import 'package:inventku/views/screen/history/history_screen.dart';
import 'package:inventku/views/screen/homepage/homepage_screen.dart';
import 'package:inventku/views/screen/item/item_screen.dart';
import 'package:inventku/views/screen/item/item_view_model.dart';
import 'package:inventku/views/screen/login/login_screen.dart';
import 'package:inventku/views/screen/navbar/navbar_screen.dart';
import 'package:inventku/views/screen/navbar/navbar_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavbarViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DbManager(),
        ),
      ],
      child: const MaterialApp(
        title: 'InventKu',
        debugShowCheckedModeBanner: false,
        // home: HomePageScreen(),
        // home: ItemScreen(),
        home: LoginScreen(),
      ),
    );
  }
}
