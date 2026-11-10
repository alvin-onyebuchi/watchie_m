import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/data/search_engine.dart';
import 'package:watchie/widgets/media_card.dart';
import 'package:watchie/widgets/recommended_movie_carouesl.dart';
import 'package:watchie/widgets/recommended_tv_corousel.dart';
import 'package:watchie/widgets/trending_movie_carousel.dart';
import 'package:watchie/widgets/trending_tv_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  List<Media> movieSearchResults = [];
  List<Media> tvSearchResults = [];
  Timer? searchDebounce;
  int searchRequedtId = 0;
  bool isTrendingMovie = true;
  bool isRecommendedMovie = true;
  bool isSearchMovie = true;
  bool isSearching = false;
  String? searchError;

  void onSearchChanged(String value) {
    searchDebounce?.cancel();
    setState(() {
      searchQuery = value;
      movieSearchResults = [];
      tvSearchResults = [];
      searchError = null;
      isSearching = value.trim().isNotEmpty;
    });

    if (value.trim().isEmpty) {
      return;
    }
    searchDebounce = Timer(Duration(milliseconds: 400), () {
      runSearch(value);
    });
  }

  Future<void> runSearch(String value) async {
    final requestId = ++searchRequedtId;

    try {
      final movieResults = await searchMovie(value);
      final tvResults = await searchTv(value);

      if (!mounted || requestId != searchRequedtId) return;

      setState(() {
        movieSearchResults = movieResults;
        tvSearchResults = tvResults;
        isSearching = false;
      });
    } catch (_) {
      if (!mounted || requestId != searchRequedtId) return;

      setState(() {
        searchError = 'Could not load search result';
        isSearching = false;
      });
    }
  }

  @override
  void dispose() {
    searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(' Watchie'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBar(
                hintText: 'Search...',
                leading: Icon(Icons.search_rounded),
                onChanged: onSearchChanged,
              ),
              searchQuery.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(),
                        Text(
                          'Your Recomendations',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isRecommendedMovie = true;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: isRecommendedMovie
                                    ? Color.fromARGB(68, 255, 2, 2)
                                    : const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Movie"),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isRecommendedMovie = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: isRecommendedMovie == false
                                    ? Color.fromARGB(68, 255, 0, 0)
                                    : const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Series"),
                            ),
                          ],
                        ),
                        recommendedTv.isEmpty || recommendedMovie.isEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text('Add Recommendations'),
                                    ),
                                  ),
                                ],
                              )
                            : isRecommendedMovie
                            ? RecommendedMovieCarouesl()
                            : RecommendedTvCorousel(),

                        SizedBox(height: 10),
                        Text(
                          'Trending',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isTrendingMovie = true;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: isTrendingMovie == true
                                    ? Color.fromARGB(68, 255, 2, 2)
                                    : const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Movie"),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isTrendingMovie = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: isTrendingMovie == false
                                    ? Color.fromARGB(68, 248, 248, 248)
                                    : const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("Series"),
                            ),
                          ],
                        ),
                        trendingTv.isEmpty
                            ? Text('dddddddd')
                            : isTrendingMovie
                            ? MovieCarousel()
                            : TvCarousel(),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isSearching
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              )
                            : searchError != null
                            ? Center(child: Text(searchError!))
                            : movieSearchResults.isEmpty &&
                                  tvSearchResults.isEmpty
                            ? Center(child: Text('No movies found'))
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isSearchMovie = true;
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                isSearchMovie == true
                                                ? Colors.white
                                                : Color.fromARGB(
                                                    68,
                                                    255,
                                                    254,
                                                    254,
                                                  ),
                                          ),
                                          child: Text(
                                            "Movie",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isSearchMovie = false;
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                isSearchMovie == false
                                                ? Colors.white
                                                : Color.fromARGB(
                                                    68,
                                                    255,
                                                    254,
                                                    254,
                                                  ),
                                          ),
                                          child: Text(
                                            "Series",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount: isSearchMovie == true
                                        ? movieSearchResults.length
                                        : tvSearchResults.length,
                                    itemBuilder: (context, index) {
                                      return MediaCard(
                                        media: isSearchMovie == true
                                            ? movieSearchResults[index]
                                            : tvSearchResults[index],
                                      );
                                    },
                                  ),
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
