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
