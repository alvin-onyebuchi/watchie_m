import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/pages/details.dart';

class MediaCard extends StatelessWidget {
  final Movie media;
  const MediaCard({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Details(movie: media);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(60, 189, 189, 189),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 0.3,
            color: const Color.fromARGB(143, 190, 190, 190),
          ),
        ),
        margin: EdgeInsets.all(5),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.network(
                  media.poster,
                  height: 100,
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
                    child: Image.asset(
                      'assets/images/no_image.jpg',
                      height: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(children: [Text(media.title)]),

                    Text(media.year.toString()),
                    Wrap(children: [Text(media.description, maxLines: 3)]),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                      SizedBox(width: 2),
                      Text(media.rating.toStringAsFixed(1)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
