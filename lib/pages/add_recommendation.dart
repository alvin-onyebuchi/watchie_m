import 'package:flutter/material.dart';

class AddRecommendation extends StatefulWidget {
  const AddRecommendation({super.key});

  @override
  State<AddRecommendation> createState() => _AddRecommendationState();
}

class _AddRecommendationState extends State<AddRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search recommendations'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Title'),
              ),
            ),
            DropdownButton(
              hint: Text('genre'),
              items: [],
              onChanged: (value) {},
              borderRadius: BorderRadius.circular(10),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('year'),
              ),
            ),
            Slider(value: 1, onChanged: (value) {}),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('description'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
