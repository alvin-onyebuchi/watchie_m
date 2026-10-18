import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/pages/details.dart';
import 'package:watchie/pages/recomendation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Recomendation();
                                  },
                                ),
                              );
                            },
                            child: Text('Add Recommendations'),
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,

                        childAspectRatio: 0.47,
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
                              Hero(
                                tag: recommended[index].poster,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: Image.asset(
                                    recommended[index].poster,
                                    width: 200,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(recommended[index].title),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.star_half_rounded,
                                      color: Colors.amber,
                                    ),
                                    Text(recommended[index].rating.toString()),
                                  ],
                                ),
                                contentPadding: EdgeInsets.only(left: 5),
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
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,

                  childAspectRatio: 0.47,
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
                        Hero(
                          tag: trending[index].poster,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.asset(
                              trending[index].poster,
                              height: 200,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(trending[index].title),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.star_half_rounded,
                                color: Colors.amber,
                              ),
                              Text(trending[index].rating.toString()),
                            ],
                          ),
                          contentPadding: EdgeInsets.only(left: 5),
                        ),
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
