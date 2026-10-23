import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watchie/const.dart';
import 'package:watchie/data/tmdb_api.dart';
import 'package:watchie/pages/home_page.dart';
import 'package:watchie/tmbd_services.dart';

int searchedIndex = 0;
Future<void> search(String searchQuery) async {
  final requesId = ++searchedIndex;

  if (searchQuery.trim().isEmpty) {
    searchedMatchedMovies.clear();
    return;
  }
  var response = await http.get(
    Uri.parse(
      'https://api.themoviedb.org/3/search/movie'
      '?query=$searchQuery',
    ),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  if (requesId != searchedIndex) return;

  var data = jsonDecode(response.body);

  searchedMatchedMovies.clear();

  List<dynamic> results = data["results"];

  for (var result in results) {
    int id = result["id"];
    double rating = result["vote_average"];
    String title = result["title"];
    String description = result["overview"];

    String poster = "https://image.tmdb.org/t/p/w500${result["poster_path"]}";
    int year = int.tryParse((result["release_date"]).substring(0, 4)) ?? 0;

    List<dynamic> genreIds = result["genre_ids"];
    List<String> genres = genreIds.map((id) {
      return genreMapId[id]!;
    }).toList();

    searchedMatchedMovies.add(
      Movie(id, title, poster, genres, year, rating, description),
    );
  }
}
