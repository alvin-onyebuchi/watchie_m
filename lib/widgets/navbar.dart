import 'package:flutter/material.dart';
import 'package:watchie/data/notifiers.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: navigationNotifier,
      builder: (context, navigator, child) {
        return NavigationBar(
          indicatorColor: const Color.fromARGB(85, 244, 67, 54),
          maintainBottomViewPadding: false,
          labelPadding: EdgeInsets.all(10),
          backgroundColor: const Color.fromARGB(95, 197, 197, 197),
          onDestinationSelected: (value) {
            navigationNotifier.value = value;
          },
          selectedIndex: navigator,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_rounded),
              label: 'Watchlist',
            ),
          ],
        );
      },
    );
  }
}
