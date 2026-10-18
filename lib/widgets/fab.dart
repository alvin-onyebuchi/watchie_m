import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/pages/add_recommendation.dart';

class Fab extends StatefulWidget {
  const Fab({super.key});

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    return recommended.isEmpty
        ? Text('')
        : FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddRecommendation();
                  },
                ),
              );
            },
            child: Icon(Icons.add_rounded, size: 30),
          );
  }
}
