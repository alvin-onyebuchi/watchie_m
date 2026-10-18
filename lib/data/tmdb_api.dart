import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchie/const.dart';
import 'package:watchie/tmbd_services.dart';

final Map<int, String> genreMapId = {
  28: 'Action',
  12: 'Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  14: 'Fantasy',
  36: 'History',
  27: 'Horror',
  10402: 'Music',
  9648: 'Mystery',
  10749: 'Romance',
  878: 'Sci-fi',
  10770: 'TV Movie',
  53: 'Thriller',
  10752: 'War',
  37: 'Western',
};
Future<void> getTrending() async {
  var response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/trending/movie/day'),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  print('statusCode: ${response.statusCode}');
  Map<String, dynamic> data = jsonDecode(response.body);
  List<dynamic> results = data["results"];
  Movie? movie;
  trending.clear();
  for (var result in results) {
    int id = result["id"];
    double rating = result["vote_average"];
    String title = result["title"];
    String description = result["overview"];
    String poster = "https://image.tmdb.org/t/p/w500" + result["poster_path"];
    int year = int.tryParse((result["release_date"]).substring(0, 4)) ?? 0;

    List<dynamic> genreIds = result["genre_ids"];
    List<String> genres = genreIds.map((id) {
      return genreMapId[id]!;
    }).toList();
    movie = Movie(id, title, poster, genres, year, rating, description);
    if (!recommended.contains(movie)) {
      trending.add(movie);
    }
  }
}
