class Media {
  int id;
  String mediaType;
  String title;
  String poster;
  List<String> genres;
  int year;
  double rating;
  String description;

  Media(
    this.id,
    this.mediaType,
    this.title,
    this.poster,
    this.genres,
    this.year,
    this.rating,
    this.description,
  );
}

String? yearRange;

List<Media> mon = [];
final List<Media> recommendedMovie = [];
final List<Media> recommendedTv = [];
final List<Media> watchlistMovie = [];
final List<Media> watchlistTv = [];
List<Media> trendingMovie = [];
List<Media> trendingTv = [];
