import 'package:flutter/material.dart';
import 'package:keep_it_safe/models/main_screen_state.dart';
import 'package:keep_it_safe/pages/generate_page.dart';
import 'package:keep_it_safe/pages/home_page.dart';
import 'package:keep_it_safe/pages/new_page.dart';
import 'package:keep_it_safe/pages/settings_page.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const id = 'main_screen';

  @override
  Widget build(BuildContext context) {
    print('does it whole thing get rebuilt');
    return Consumer<MainScreenState>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: state.page),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.lightBlueAccent,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            currentIndex: state.pageIdx,
            items: _getBottomNavigationBarItems(),
            onTap: (index) {
              int bottomBarItemIndex = state.pageIdx;

              if (index == bottomBarItemIndex) return;

              Widget page;

              if (index == 0) {
                // Settings
                page = SettingsPage();
              } else if (index == 1) {
                // New
                page = NewPage();
              } else if (index == 2) {
                // Home
                page = HomePage();
              } else if (index == 3) {
                // Generate
                page = GeneratePage();
              } else {
                // Logout
                Navigator.popUntil(context, (route) => route.isFirst);
                return;
              }

              state.setPage(index, page);
            },
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'New',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.create),
        label: 'Generate',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.logout),
        label: 'Logout',
      ),
    ];
  }
}
