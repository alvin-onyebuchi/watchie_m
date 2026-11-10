import 'package:flutter/material.dart';
import 'package:watchie/const.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {
  final Media media;

  const Details({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: media.id,
              child: Card(
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.network(
                    media.poster,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 2,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Image.asset('assets/images/no_image.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(media.title),
                    Text(media.genres.join(',')),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber),
                        Text(media.rating.toStringAsFixed(1)),
                      ],
                    ),
                    Text(media.year.toString()),
                    Text(media.description),
                  ],
                ),
              ),
            ),
            watchlistTv.contains(media) || watchlistMovie.contains(media)
                ? Text('')
                : Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            if (!watchlistMovie.contains(media) &&
                                media.mediaType == "movie") {
                              watchlistMovie.add(media);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${media.title} added to your watchlist',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } else if (!watchlistTv.contains(media) &&
                                media.mediaType == "tv") {
                              watchlistTv.add(media);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${media.title} added to your watchlist',
                                  ),
                                ),
                              );
                              Navigator.pop(context);
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
