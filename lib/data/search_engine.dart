import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watchie/const.dart';
import 'package:watchie/data/trending_engine.dart';
import 'package:watchie/tmbd_services.dart';

Future<List<Media>> searchMovie(String searchQuery) async {
  final query = searchQuery.trim();

  if (query.isEmpty) {
    return [];
  }

  final response = await http.get(
    Uri.parse(
      'https://api.themoviedb.org/3/search/movie'
      '?query=$query',
    ),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  print(response.statusCode);
  if (response.statusCode != 200) {
    throw Exception("Movie search fail (${response.statusCode})");
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;

  final results = data["results"] as List<dynamic>? ?? [];
  // print(data);

  return results.map((item) {
    final result = item as Map<String, dynamic>;

    final id = result["id"];
    final String mediaType = "movie";

    double rating = result["vote_average"];

    final String title = result["title"];
    String description = result["overview"];
    final posterPath = result["poster_path"] as String?;

    final poster = posterPath == null
        ? ''
        : "https://image.tmdb.org/t/p/w500$posterPath";

    final releaseDate = result["release_date"] as String? ?? '';

    final year = releaseDate.length >= 4
        ? int.tryParse(releaseDate.substring(0, 4)) ?? 0
        : 0;

    List<dynamic> genreIds = result["genre_ids"];
    List<String> genres = genreIds.map((id) {
      return genreMapId[id]!;
    }).toList();

    print(title);
    return Media(
      id,
      mediaType,
      title,
      poster,
      genres,
      year,
      rating,
      description,
    );
  }).toList();
}

Future<List<Media>> searchTv(String searchQuery) async {
  final query = searchQuery.trim();

  if (query.isEmpty) {
    return [];
  }

  final response = await http.get(
    Uri.parse(
      'https://api.themoviedb.org/3/search/tv'
      '?query=$query',
    ),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  print(response.statusCode);
  if (response.statusCode != 200) {
    throw Exception("Movie search fail (${response.statusCode})");
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;

  final results = data["results"] as List<dynamic>? ?? [];
  // print(data);

  return results.map((item) {
    final result = item as Map<String, dynamic>;

    final id = result["id"];
    final String mediaType = "tv";
    double rating = result["vote_average"];

    final String title = result["name"];
    String description = result["overview"];
    final posterPath = result["poster_path"] as String?;

    final poster = posterPath == null
        ? ''
        : "https://image.tmdb.org/t/p/w500$posterPath";
    final releaseDate = result["first_air_date"] as String? ?? '';

    final year = releaseDate.length >= 4
        ? int.tryParse(releaseDate.substring(0, 4)) ?? 0
        : 0;

    List<dynamic> genreIds = result["genre_ids"];
    List<String> genres = genreIds.map((id) {
      return tvGenreMapId[id]!;
    }).toList();
    print('$title ');

    return Media(
      id,
      mediaType,
      title,
      poster,
      genres,
      year,
      rating,
      description,
    );
  }).toList();
}
