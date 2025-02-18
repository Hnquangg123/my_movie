import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/exception.dart';
import 'package:my_movie/domain/movie_detail/entities/movie_detail.dart';

@lazySingleton
@Injectable()
class FetchMovieDetailService {
  final http.Client client;

  FetchMovieDetailService({required this.client});

  Future<MovieDetail> fetchMovieDetail(int id) async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client
        .get(Uri.parse('https://api.themoviedb.org/3/movie/$id'), headers: {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieDetail(
        title: data['title'] ?? 'Unknown',
        overview: data['overview'] ?? 'No overview available',
        posterPath: data['poster_path'] ?? '',
        backdropPath: data['backdrop_path'] ?? '',
        releaseDate: data['release_date'] ?? 'Unknown',
        voteAverage: (data['vote_average'] as num?)?.toDouble() ?? 0.0,
        voteCount: data['vote_count'] ?? 0,
        // genres: List<String>.from(data['genres'] ?? []),
        genres: (data['genres'] as List)
            .map((genre) => genre['name'].toString())
            .toList(),
        tagLine: data['tagline'] ?? 'This movie has no tagline',
      );
    } else {
      throw ServerException();
    }
  }
}
