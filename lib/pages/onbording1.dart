import 'package:flutter/material.dart';
import 'package:watchie/const.dart';
import 'package:watchie/data/recommendation_engine.dart';
import 'package:watchie/data/tmdb_api.dart';
import 'package:watchie/view/widget_tree.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Self recommend'),
        centerTitle: true,
        //actions: [TextButton(onPressed: () {}, child: Text('Skip'))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('What Genres do you like?'),
            SizedBox(height: 10),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Action');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Action')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Action')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),

                  child: Text('Action'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Horror');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Horror')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Horror')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Horror'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Thriller');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Thriller')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Thriller')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Thriller'),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Comedy');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Comedy')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Comedy')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Comedy'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Romance');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Romance')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Romance')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Romance'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Sci-fi');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Sci-fi')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Sci-fi')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Sci-fi'),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Drama');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Drama')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Drama')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Drama'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      addGenre('Animation');
                      print(genres);
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: genres.contains('Animation')
                        ? Colors.white
                        : const Color.fromARGB(255, 72, 190, 26),
                    backgroundColor: genres.contains('Animation')
                        ? const Color.fromARGB(255, 72, 190, 26)
                        : const Color.fromARGB(0, 255, 255, 255),
                  ),
                  child: Text('Animation'),
                ),
              ],
            ),
            Divider(),

            Text('What release year do you prefer?'),

            DropdownButton(
              hint: Text('Choose year'),
              value: yearRange,

              isExpanded: true,
              items: [
                DropdownMenuItem(value: 'Any year', child: Text('Any year')),
                DropdownMenuItem(value: '2020-2026', child: Text('2020-2026')),
                DropdownMenuItem(value: '2010-2019', child: Text('2010-2019')),
                DropdownMenuItem(value: '2000-2009', child: Text('2000-2009')),
                DropdownMenuItem(value: 'Older', child: Text('Older')),
              ],
              onChanged: (value) {
                setState(() {
                  yearRange = value;
                  matchesYear(yearRange!);
                  print('$year1 $year2 $yearRange');
                });
              },
            ),

            Divider(),
            Text('What rating do you prefer?'),
            Column(
              children: [
                Slider(
                  value: rating,
                  thumbColor: const Color.fromARGB(255, 72, 190, 26),
                  activeColor: const Color.fromARGB(255, 72, 190, 26),
                  secondaryActiveColor: const Color.fromARGB(255, 72, 190, 26),

                  max: 10,
                  label: rating.toStringAsFixed(1),
                  showValueIndicator: ShowValueIndicator.onDrag,
                  onChanged: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_half_rounded, color: Colors.amber),
                    Text(rating.toStringAsFixed(1)),
                  ],
                ),
              ],
            ),
            Divider(),

            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (!mounted) return;

                            setState(() {
                              isLoading = true;
                            });

                            try {
                              await getTrending();
                              if (!mounted) return;

                              await recommendations();
                              if (!mounted) return;

                              if (genres.isNotEmpty &&
                                  rating != 0 &&
                                  yearRange != null) {
                                if (!mounted) return;

                                Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WidgetTree(),
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          genres.isNotEmpty && rating != 0 && yearRange != null
                          ? Color.fromARGB(255, 72, 190, 26)
                          : const Color.fromARGB(0, 0, 0, 0),
                      foregroundColor: Colors.white,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Continue'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
