import 'package:flutter/material.dart';
import 'package:inventku/views/screen/history/history_screen.dart';
import 'package:inventku/views/screen/item/item_screen.dart';

Route createRouteItemScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const ItemScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
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
