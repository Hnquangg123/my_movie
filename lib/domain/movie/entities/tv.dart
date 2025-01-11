class TV {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String firstAirDate;

  TV({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
  });

  @override
  String toString() {
    return 'TV{id: $id, title: $title, overview: $overview, posterPath: $posterPath, first_air_date: $firstAirDate}';
  }
}
