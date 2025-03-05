class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String mediaType = 'movie';
  final List<double> embedding;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.embedding,
  });

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, overview: $overview, posterPath: $posterPath, releaseDate: $releaseDate}';
  }

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String,
      releaseDate: json['release_date'] as String,
      posterPath: json['poster_path'] as String? ?? '',
      embedding: (json['embedding'] as List<double>).map((e) => e.toDouble()).toList(),
    );
  }
  
}
