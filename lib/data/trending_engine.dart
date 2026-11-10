import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:watchie/const.dart';
import 'package:watchie/tmbd_services.dart';

Map<int, String> tvGenreMapId = {
  10759: 'Action & Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  10762: 'Kids',
  9648: 'Mystery',
  10763: 'News',
  10764: 'Reality',
  10765: 'Sci-Fi & Fantasy',
  10766: 'Soap',
  10767: 'Talk',
  10768: 'War & Politics',
  37: 'Western',
};

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

  trendingMovie.clear();
  for (var result in results) {
    int id = result["id"];
    String mediaType = "movie";
    double rating = result["vote_average"];
    String title = result["title"];
    String description = result["overview"];
    String poster = "https://image.tmdb.org/t/p/w500${result["poster_path"]}";
    int year = int.tryParse((result["release_date"]).substring(0, 4)) ?? 0;

    List<dynamic> genreIds = result["genre_ids"];
    List<String> genres = genreIds.map((id) {
      return genreMapId[id]!;
    }).toList();
    Media movie = Media(
      id,
      mediaType,
      title,
      poster,
      genres,
      year,
      rating,
      description,
    );

    trendingMovie.add(movie);
  }
}

Future<void> getTrendingTv() async {
  var response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/trending/tv/day'),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  print('statusCode: ${response.statusCode}');
  Map<String, dynamic> data = jsonDecode(response.body);
  List<dynamic> results = data["results"];

  trendingTv.clear();
  for (var result in results) {
    int id = result["id"];
    String mediaType = "tv";
    double rating = result["vote_average"];
    String title = result["name"];
    String description = result["overview"];
    String poster = "https://image.tmdb.org/t/p/w500${result["poster_path"]}";
    int year = int.tryParse((result["first_air_date"]).substring(0, 4)) ?? 0;

    List<dynamic> genreIds = result["genre_ids"];
    List<String> genres = genreIds.map((id) {
      return tvGenreMapId[id]!;
    }).toList();
    Media tv = Media(
      id,
      mediaType,
      title,
      poster,
      genres,
      year,
      rating,
      description,
    );

    trendingTv.add(tv);
  }
}
