import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/pages/details.dart';

class RecommendedMovieCarouesl extends StatefulWidget {
  const RecommendedMovieCarouesl({super.key});

  @override
  State<RecommendedMovieCarouesl> createState() =>
      _RecommendedMovieCaroueslState();
}

class _RecommendedMovieCaroueslState extends State<RecommendedMovieCarouesl> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: CarouselView(
        infinite: true,
        itemExtent: 120,
        itemSnapping: true,
        onTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Details(movie: recommendedMovie[index]);
              },
            ),
          );
        },

        children: List.generate(recommendedMovie.length, (index) {
          return Card(
            shape: Border.all(style: BorderStyle.none),
            margin: EdgeInsets.all(0),
            child: ClipRRect(
              child: Image.network(
                recommendedMovie[index].poster,
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
