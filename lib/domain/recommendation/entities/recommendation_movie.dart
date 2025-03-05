class RecommendationMovie {
  final int id;
  final String title;
  final String posterPath;
  final String mediaType = 'movie';
  final double similarity;

  RecommendationMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.similarity,
  });

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, posterPath: $posterPath, similarity: $similarity}';
  }

  factory RecommendationMovie.fromJson(Map<String, dynamic> json) {
    return RecommendationMovie(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String? ?? '',
      similarity: json['similarity'] as double,
    );
  }
  
}
