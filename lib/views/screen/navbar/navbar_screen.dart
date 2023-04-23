import 'package:flutter/material.dart';
import 'package:inventku/views/screen/navbar/navbar_view_model.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavbarViewModel>(context);
    return Scaffold(
      body: provider.items[provider.selectedIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.selectedIndex,
          onTap: (value) {
            provider.selectedIndex = value;
          },
          items: provider.items
              .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData), label: e.label))
              .toList()),
    );
  }
}
