import 'package:flutter/material.dart';
import 'package:watchie/data/notifiers.dart';
import 'package:watchie/pages/home_page.dart';
import 'package:watchie/pages/watchlist.dart';
import 'package:watchie/widgets/navbar.dart';

List<Widget> pages = [HomePage(), Watchlist()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: navigationNotifier,
        builder: (context, navigator, child) {
          return pages.elementAt(navigator);
        },
      ),
      // floatingActionButton: Fab(),
      bottomNavigationBar: Navbar(),
    );
  }
}
