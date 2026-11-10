import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watchie/const.dart';
import 'package:watchie/data/trending_engine.dart';
import 'package:watchie/tmbd_services.dart';

Map<String, int> tvGenreMap = {
  'Action & Adventure': 10759,
  'Animation': 16,
  'Comedy': 35,
  'Crime': 80,
  'Documentary': 99,
  'Drama': 18,
  'Family': 10751,
  'Kids': 10762,
  'Mystery': 9648,
  'News': 10763,
  'Reality': 10764,
  'Sci-Fi & Fantasy': 10765,
  'Soap': 10766,
  'Talk': 10767,
  'War & Politics': 10768,
  'Western': 37,
};
final Map<String, int> genreMap = {
  'Action': 28,
  'Adventure': 12,
  'Animation': 16,
  'Comedy': 35,
  'Crime': 80,
  'Documentary': 99,
  'Drama': 18,
  'Family': 10751,
  'Fantasy': 14,
  'History': 36,
  'Horror': 27,
  'Music': 10402,
  'Mystery': 9648,
  'Romance': 10749,
  'Sci-fi': 878,
  'TV Movie': 10770,
  'Thriller': 53,
  'War': 10752,
  'Western': 37,
};
int? year1;
int? year2;
double rating = 0;
List<int> movieGenreids = [];
List<int> tvGenreids = [];
List<String> tvGenres = [];
List<String> movieGenres = [];
Future<http.Response> getRecomendationMovie() async {
  print('$year1 $year2 $movieGenreids $rating');
  var response = await http.get(
    Uri.parse(
      'https://api.themoviedb.org/3/discover/movie'
      '?primary_release_date.gte=$year1-01-01'
      '&primary_release_date.lte=$year2-12-31'
      '&with_genres=${movieGenreids.join(',')}'
      '&vote_average.gte=$rating',
    ),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  return response;
}

Future<void> recommendationMovie() async {
  var response = await getRecomendationMovie();
  print('statusCode: ${response.statusCode}');
  print('body length: ${response.body.length}');
  var data = jsonDecode(response.body);
  print(data);
  List<dynamic> results = data["results"];
  for (var result in results.take(5)) {
    print('${result["title"]} -> ${result["release_date"]}');
  }
  Media? movie;
  recommendedMovie.clear();
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
    movie = Media(
      id,
      mediaType,
      title,
      poster,
      genres,
      year,
      rating,
      description,
    );

    recommendedMovie.add(movie);
  }
}

Future<http.Response> getRecomendationTv() async {
  print('$year1 $year2 $tvGenreids $rating');
  var response = await http.get(
    Uri.parse(
      'https://api.themoviedb.org/3/discover/tv'
      '?primary_first_air_date.gte=$year1-01-01'
      '&primary_first_air_date.lte=$year2-12-31'
      '&with_genres=${tvGenreids.join(',')}'
      '&vote_average.gte=$rating',
    ),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  return response;
}

Future<void> recommendationTv() async {
  var response = await getRecomendationTv();
  print('statusCode: ${response.statusCode}');
  print('body length: ${response.body.length}');
  var data = jsonDecode(response.body);
  print(data);
  List<dynamic> results = data["results"];
  // for (var result in results.take(5)) {
  //   print('${result["title"]} -> ${result["release_date"]}');
  // }
  Media? movie;
  recommendedTv.clear();
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
    movie = Media(
      id,
      mediaType,
      title,
      poster,
      genres,
      year,
      rating,
      description,
    );

    recommendedTv.add(movie);
  }
}

void addGenreMovie(String gnre) async {
  if (!movieGenres.contains(gnre)) {
    movieGenres.add(gnre);
    movieGenreids = movieGenres.map((e) {
      return genreMap[e]!;
    }).toList();
    return;
  }
}

void addGenreTv(String gnre) async {
  if (!tvGenres.contains(gnre)) {
    tvGenres.add(gnre);
    tvGenreids = tvGenres.map((e) {
      return tvGenreMap[e]!;
    }).toList();
    return;
  }
}

void matchesYear(String yearRange) {
  if (yearRange == 'Any year') {
    year1 = 1860;
    year2 = 2026;
  } else if (yearRange == '2020-2026') {
    year1 = 2020;
    year2 = 2026;
  } else if (yearRange == '2010-2019') {
    year1 = 2010;
    year2 = 2019;
  } else if (yearRange == '2000-2009') {
    year1 = 2000;
    year2 = 2009;
  } else if (yearRange == 'Older') {
    year1 = 1900;
    year2 = 1999;
  }

  return;
}
