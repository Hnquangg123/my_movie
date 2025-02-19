class MovieDetail {
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;
  final String tagLine;

  MovieDetail({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.tagLine,
  });

  @override
  String toString() {
    return 'MovieDetail{title: $title, overview: $overview, posterPath: $posterPath, backdropPath: $backdropPath, releaseDate: $releaseDate, voteAverage: $voteAverage, voteCount: $voteCount, genres: $genres, tagLine: $tagLine}';
  }
}
