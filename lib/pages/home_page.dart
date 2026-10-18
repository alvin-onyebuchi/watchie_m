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
  bool isLoadingrecommendation = false;

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
                onChanged: (value) async {
                  await search(value);
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: searchedMatchedMovies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Details(
                                  movie: searchedMatchedMovies[index],
                                );
                              },
                            ),
                          );
                        },
                        leading: Image.network(
                          searchedMatchedMovies[index].poster,
                        ),
                        title: Text(searchedMatchedMovies[index].title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  searchedMatchedMovies[index].rating
                                      .toString(),
                                ),
                                Icon(
                                  Icons.star_half_rounded,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                            Text(searchedMatchedMovies[index].genres.join(',')),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              Text(
                'Your Recomendations',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              recommended.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Add Recommendations'),
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,

                        childAspectRatio: 0.65,
                      ),
                      itemCount: recommended.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Details(movie: recommended[index]);
                                },
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: Image.network(
                                    recommended[index].poster,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return SizedBox(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.broken_image);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

              SizedBox(height: 10),
              Text(
                'Trending',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              trending.isEmpty
                  ? Text('dddddddd')
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,

                        childAspectRatio: 0.65,
                      ),
                      itemCount: trending.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Details(movie: trending[index]);
                                },
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Card(
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                    child: Image.network(
                                      trending[index].poster,
                                    ),
                                  ),
                                ),
                              ),
                              // ListTile(
                              //   title: Text(trending[index].title),
                              //   subtitle: Row(
                              //     children: [
                              //       Icon(
                              //         Icons.star_half_rounded,
                              //         color: Colors.amber,
                              //       ),
                              //       Text(
                              //         trending[index].rating.toStringAsFixed(1),
                              //       ),
                              //     ],
                              //   ),
                              //   contentPadding: EdgeInsets.only(left: 5),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
