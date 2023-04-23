import 'package:flutter/material.dart';
import 'package:inventku/views/screen/history/history_screen.dart';
import 'package:inventku/views/screen/homepage/homepage_screen.dart';
import 'package:inventku/views/screen/item/item_screen.dart';

class NavbarViewModel with ChangeNotifier {
  List<NavbarDTO> items = [
    NavbarDTO(
        label: 'Home', widget: HomePageScreen(), iconData: Icons.home_rounded),
    NavbarDTO(
        label: 'Barang',
        widget: ItemScreen(),
        iconData: Icons.dashboard_customize),
    NavbarDTO(
        label: 'Riwayat',
        widget: HistoryScreen(),
        iconData: Icons.manage_history_rounded),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}

class NavbarDTO {
  Widget? widget;
  String? label;

  IconData? iconData;

  NavbarDTO({this.widget, this.label, this.iconData});
}
