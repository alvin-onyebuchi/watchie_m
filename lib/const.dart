class Movie {
  String title;
  String poster;
  List<String> genres;
  int year;
  double rating;
  String description;
  bool trending;

  Movie(
    this.title,
    this.poster,
    this.genres,
    this.year,
    this.rating,
    this.description,
    this.trending,
  );
}

List<String> genres = [];
String? yearRange;
double rating = 0;
List<Movie> movies = [
  Movie(
    "The Batman",
    'assets/images/The_Batman.png',
    ["Action", "Thriller", "Superhero"],
    2022,
    7.8,
    "The Batman is a 2022 crime-thriller film directed by Matt Reeves that follows Bruce Wayne (Robert Pattinson) during his second year as Gotham City's vigilante.",
    true,
  ),
  Movie(
    "Swapped",
    'assets/images/swapped.jpeg',
    ["Adventure", "Comedy", "Animation"],
    2026,
    7.2,
    "Swapped is a 2026 animated fantasy-comedy film from Skydance Animation and director Nathan Greno that follows two sworn animal enemies who accidentally switched bodies",
    false,
  ),
  Movie(
    "Spider-Man: Brand new day",
    'assets/images/spider-man_bnd.jpeg',
    ["Action", "Sci-fi", "Superhero"],
    2026,
    7.4,
    "Peter Parker (Tom Holland) works full-time as a street-level hero in a world that completely forgot he exists. Struggling with isolation and watching his old friends move on, Peter faces unexpected surges in his powers and a dangerous new threat in New York City. The movie is directed by Destin Daniel Cretton and co-stars Zendaya, Jon Bernthal as Frank Castle/The Punisher, and Mark Ruffalo as Bruce Banner.",
    true,
  ),
  Movie(
    "Odyssey",
    'assets/images/odyssey.jpeg',
    ["Action", "Aventure", "Fantacy"],
    2026,
    8.4,
    "The Odyssey is a 2026 epic action film adapting Homer's ancient Greek poem about King Odysseus's dangerous, decade-long journey home after the Trojan War.",
    true,
  ),
  Movie(
    "Dune: Part One",
    'assets/images/dune.jpeg',
    ["Action", "Sci-fi"],
    2021,
    8.0,
    "Dune: Part One is a 2021 epic science fiction film directed by Denis Villeneuve that adapts the first half of Frank Herbert's classic 1965 novel.",
    false,
  ),
  Movie(
    "The Excorcist",
    'assets/images/excor.jpg',
    ["Horror"],
    1973,
    8.0,
    "The Exorcist is about a 12-year-old girl named Regan who becomes possessed by a malevolent demon and the desperate efforts of two Catholic priests to save her soul through an exorcism",
    false,
  ),
  Movie(
    "Interstellar",
    'assets/images/inter.jpg',
    ["Sci-fi", "Suspence", "Adventure"],
    2014,
    8.7,
    "Interstellar (2014) is a science fiction film directed by Christopher Nolan about a group of astronauts who travel through a wormhole to find a new home as Earth dies.",
    true,
  ),
];
final List<Movie> recommended = [];
final List<Movie> watchlist = [];
final List<Movie> trending = [];
