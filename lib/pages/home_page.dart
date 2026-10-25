import 'dart:async';

import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/data/search_engine.dart';
import 'package:watchie/pages/details.dart';

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
                        recommended.isEmpty
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
                            : SizedBox(
                                height: 150,
                                child: CarouselView(
                                  itemExtent: 100,
                                  itemSnapping: true,
                                  onTap: (index) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Details(
                                            movie: recommended[index],
                                          );
                                        },
                                      ),
                                    );
                                  },

                                  children: List.generate(recommended.length, (
                                    index,
                                  ) {
                                    return Container(
                                      child: ClipRRect(
                                        child: Image.network(
                                          recommended[index].poster,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.red,
                                                        strokeWidth: 2,
                                                      ),
                                                );
                                              },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),

                        SizedBox(height: 10),
                        Text(
                          'Trending',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trending.isEmpty
                            ? Text('dddddddd')
                            : SizedBox(
                                height: 150,
                                child: CarouselView(
                                  itemExtent: 100,
                                  itemSnapping: true,
                                  onTap: (index) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Details(
                                            movie: trending[index],
                                          );
                                        },
                                      ),
                                    );
                                  },

                                  children: List.generate(trending.length, (
                                    index,
                                  ) {
                                    return ClipRRect(
                                      child: Image.network(
                                        trending[index].poster,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.red,
                                                      strokeWidth: 2,
                                                    ),
                                              );
                                            },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                                  child: Icon(
                                                    Icons.broken_image,
                                                  ),
                                                ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
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
