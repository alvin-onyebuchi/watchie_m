import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/data/search_engine.dart';
import 'package:watchie/pages/details.dart';
import 'package:watchie/widgets/recommended_movie_carouesl.dart';
import 'package:watchie/widgets/recommended_tv_corousel.dart';
import 'package:watchie/widgets/trending_movie_carousel.dart';
import 'package:watchie/widgets/trending_tv_carousel.dart';

List<Movie> searchedMatchedMovies = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  List<Movie> searchResults = [];
  Timer? searchDebounce;
  int searchRequedtId = 0;
  bool isTrendingMovie = true;
  bool isRecommendedMovie = true;
  bool isSearching = false;
  String? searchError;
  Future<void> runSearch(String value) async {
    final requestId = ++searchRequedtId;

    try {
      final results = await search(value);
      if (!mounted || requestId != searchRequedtId) return;
      setState(() {
        searchResults = results;
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

  void onSearchChanged(String value) {
    searchDebounce?.cancel();
    setState(() {
      searchQuery = value;
      searchResults = [];
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
                              child: Text(
                                "Movie",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isRecommendedMovie = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(70, 20),
                                backgroundColor: isRecommendedMovie == false
                                    ? Color.fromARGB(68, 255, 2, 2)
                                    : const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("TV", style: TextStyle(fontSize: 10)),
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
                              child: Text(
                                "Movie",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isTrendingMovie = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(70, 20),
                                backgroundColor: isTrendingMovie == false
                                    ? Color.fromARGB(68, 255, 2, 2)
                                    : const Color.fromARGB(0, 0, 0, 0),
                                foregroundColor: Colors.white,
                              ),
                              child: Text("TV", style: TextStyle(fontSize: 10)),
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
                            ? const Center(child: CircularProgressIndicator())
                            : searchError != null
                            ? Center(child: Text(searchError!))
                            : searchResults.isEmpty
                            ? Center(child: Text('No movies found'))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Details(
                                              movie: searchResults[index],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    leading: Image.network(
                                      searchResults[index].poster,
                                    ),
                                    title: Text(searchResults[index].title),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              searchResults[index].rating
                                                  .toString(),
                                            ),
                                            Icon(
                                              Icons.star_half_rounded,
                                              color: Colors.amber,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          searchResults[index].genres.join(','),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
