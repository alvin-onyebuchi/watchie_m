import 'dart:convert';

import 'package:http/http.dart' as http;

import 'secrets.dart';

String tmbdApiKey = apiKey;
Future<http.Response> getTv() async {
  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/trending/tv/day'),
    headers: {
      "Authorization": "Bearer $tmbdApiKey",
      "accept": "application/json",
    },
  );
  return response;
}

Future<void> main() async {
  final res = await getTv();
  print(res.body);
  var data = jsonDecode(res.body);
}
