import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/pages/details.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Your watchlist'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: watchlist.isNotEmpty
            ? ListView.builder(
                itemCount: watchlist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  setState(() {
                                    watchlist.removeAt(index);
                                    Navigator.pop(context);
                                  });
                                },
                                child: Text('Delete'),
                              ),
                            ],

                            content: Text('Delete ${watchlist[index].title}'),
                          );
                        },
                      );
                    },
                    leading: Hero(
                      tag: watchlist[index].id,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(5),
                        child: Image.network(watchlist[index].poster),
                      ),
                    ),
                    title: Text(watchlist[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(watchlist[index].rating.toString()),
                            Icon(Icons.star_half_rounded, color: Colors.amber),
                          ],
                        ),
                        Text(watchlist[index].genres.join(',')),
                      ],
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Details(movie: watchlist[index]);
                          },
                        ),
                      );
                    },
                  );
                },
              )
            : Column(
                children: [
                  Text('Your Watchlist is empty'),
                  Text('Go home tap on movie and add to watchlist '),
                ],
              ),
      ),
    );
  }
}
