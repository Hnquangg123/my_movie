import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:my_movie/core/error/exception.dart';
import 'package:my_movie/domain/movie/entities/movie.dart';
import 'package:my_movie/domain/movie/entities/tv.dart';

@lazySingleton
@Injectable()
class TMDBService {
  final http.Client client;

  TMDBService({required this.client});

  Future<List<dynamic>> searchMovies(String query) async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/search/multi?query=$query'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // filter person
      final filteredData = (data['results'] as List)
          .where((movie) =>
              movie['media_type'] == 'movie' || movie['media_type'] == 'tv')
          .toList();

      // print(data);
      final listData = filteredData.map((movie) {
        if (movie['media_type'] == 'movie') {
          return Movie(
            id: movie['id'] ?? 0,
            title: movie['title'] ?? 'Unknown',
            overview: movie['overview'] ?? 'No overview available',
            posterPath: movie['poster_path'] ?? '',
            releaseDate: movie['release_date'] ?? 'Unknown',
          );
        } else {
          return TV(
            id: movie['id'] ?? 0,
            title: movie['name'] ?? 'Unknown',
            overview: movie['overview'] ?? 'No overview available',
            posterPath: movie['poster_path'] ?? '',
            firstAirDate: movie['first_air_date'] ?? 'Unknown',
          );
        }
      }).toList(); // Convert the map result to a list

      return listData;
    } else {
      throw ServerException();
    }
  }
}
