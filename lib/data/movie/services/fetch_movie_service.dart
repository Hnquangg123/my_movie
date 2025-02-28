import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/exception.dart';
import 'package:my_movie/domain/movie/entities/movie.dart';
import 'package:my_movie/domain/movie/entities/tv.dart';

@singleton
@Injectable()
class FetchMovieService {
  final http.Client client;

  FetchMovieService({required this.client});

  Future<List<Movie>> fetchPopularMovies() async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final listData = (data['results'] as List)
          .map((movie) => Movie(
                id: movie['id'] ?? 0,
                title: movie['title'] ?? 'Unknown',
                overview: movie['overview'] ?? 'No overview available',
                posterPath: movie['poster_path'] ?? '',
                releaseDate: movie['release_date'] ?? 'Unknown',
              ))
          .toList();
      return listData;
    } else {
      throw ServerException();
    }
  }

  Future<List<Movie>> fetchNowPlayingrMovies() async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/movie/now_playing'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movie) => Movie(
                id: movie['id'] ?? 0,
                title: movie['title'] ?? 'Unknown',
                overview: movie['overview'] ?? 'No overview available',
                posterPath: movie['poster_path'] ?? '',
                releaseDate: movie['release_date'] ?? 'Unknown',
              ))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<dynamic>> fetchTrendingMoviesAndTV() async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/trending/all/week'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final listData = (data['results'] as List).map((movie) {
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

  Future<List<dynamic>> fetchTVSeriesAirToday() async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/tv/airing_today'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final listData = (data['results'] as List)
          .map((tv) => TV(
                id: tv['id'] ?? 0,
                title: tv['name'] ?? 'Unknown',
                overview: tv['overview'] ?? 'No overview available',
                posterPath: tv['poster_path'] ?? '',
                firstAirDate: tv['first_air_date'] ?? 'Unknown',
              ))
          .toList();

      return listData;
    } else {
      throw ServerException();
    }
  }
}
