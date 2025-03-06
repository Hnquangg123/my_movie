class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String mediaType = 'movie';

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, overview: $overview, posterPath: $posterPath, releaseDate: $releaseDate}';
  }
  
}
