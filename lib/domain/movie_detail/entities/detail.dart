class Detail {
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;

  Detail({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  String toString() {
    return 'Detail{title: $title, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, voteAverage: $voteAverage}';
  }
}
