import 'package:watchie/const.dart';

void addGenre(String gnre) {
  if (!genres.contains(gnre)) {
    genres.add(gnre);
    return;
  }
}

bool matchesYear(Movie movie) {
  if (yearRange == 'Any year') {
    return true;
  } else if (yearRange == '2020-2026') {
    return movie.year >= 2020 && movie.year <= 2026;
  } else if (yearRange == '2010-2019') {
    return movie.year >= 2010 && movie.year <= 2019;
  } else if (yearRange == '2000-2009') {
    return movie.year >= 2000 && movie.year <= 2009;
  } else if (yearRange == 'Older') {
    return movie.year < 1999;
  }
  return false;
}

void addRecommendation() {
  for (var movie in movies) {
    bool year = matchesYear(movie);

    if (movie.genres.any((genre) => genres.contains(genre)) &&
        year &&
        movie.rating >= rating - 1) {
      recommended.add(movie);
    }
  }
}

void addTrend() {
  for (var movie in movies) {
    if (movie.trending && !recommended.contains(movie)) {
      trending.add(movie);
    }
  }
}
