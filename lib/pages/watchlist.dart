import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/widgets/media_card.dart';

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
                  return MediaCard(media: watchlist[index]);
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
