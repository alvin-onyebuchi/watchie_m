import 'package:flutter/material.dart';
import 'package:watchie/const.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  final Movie movie;

  const Details({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.network(movie.poster),
              ),
            ),
            Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title),
                    Text(movie.genres.join(',')),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber),
                        Text(movie.rating.toStringAsFixed(1)),
                      ],
                    ),
                    Text(movie.year.toString()),
                    Text(movie.description),
                  ],
                ),
              ),
            ),
            watchlist.contains(movie)
                ? Text('')
                : Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            if (!watchlist.contains(movie)) {
                              watchlist.add(movie);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${movie.title} added to your watchlist',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Already add to your watchlist',
                                  ),
                                ),
                              );
                            }
                          },
                          style: FilledButton.styleFrom(
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(10),
                            ),
                          ),
                          child: Text('Add to watchlist'),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
