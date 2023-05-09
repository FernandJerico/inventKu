import 'package:flutter/material.dart';
import 'package:inventku/views/screen/history/history_screen.dart';
import 'package:inventku/views/screen/item/item_screen.dart';

Route createRouteItemScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ItemScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: 0.0, end: 1.0);

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRouteHistoryScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const HistoryScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: 0.0, end: 1.0);

      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}
