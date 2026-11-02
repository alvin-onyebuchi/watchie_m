import 'package:flutter/material.dart';
import 'package:watchie/const.dart';

class MovieListContainer extends StatefulWidget {
  final Movie movie;

  const MovieListContainer({super.key, required this.movie});

  @override
  State<MovieListContainer> createState() => _MovieListContainerState();
}

class _MovieListContainerState extends State<MovieListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(children: []),
    );
  }
}
