import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/pages/details.dart';

class MovieCarousel extends StatefulWidget {
  const MovieCarousel({super.key});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: CarouselView(
        itemExtent: 120,
        itemSnapping: true,
        onTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Details(movie: trendingMovie[index]);
              },
            ),
          );
        },

        children: List.generate(trendingMovie.length, (index) {
          return Card(
            shape: Border.all(style: BorderStyle.none),
            margin: EdgeInsets.all(0),
            child: ClipRRect(
              child: Image.network(
                trendingMovie[index].poster,
                fit: BoxFit.cover,
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
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.broken_image)),
              ),
            ),
          );
        }),
      ),
    );
  }
}
