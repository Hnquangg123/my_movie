import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/exception.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';

@lazySingleton
@Injectable()
class FetchVideoService {
  final http.Client client;

  FetchVideoService({required this.client});

  Future<List<Video>> fetchVideosMovie(int movieId) async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final listData = (data['results'] as List)
          .map((video) => Video(
                id: video['id'] ?? '',
                key: video['key'] ?? '',
                name: video['name'] ?? 'Unknown',
                site: video['site'] ?? 'Unknown',
                size: video['size'] ?? 0,
                type: video['type'] ?? 'Unknown',
              ))
          .toList();
      return listData;
    } else {
      throw ServerException();
    }
  }

  Future<List<Video>> fetchVideosTV(int tvId) async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await client.get(
      Uri.parse('https://api.themoviedb.org/3/tv/$tvId/videos'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final listData = (data['results'] as List)
          .map((video) => Video(
                id: video['id'] ?? '',
                key: video['key'] ?? '',
                name: video['name'] ?? 'Unknown',
                site: video['site'] ?? 'Unknown',
                size: video['size'] ?? 0,
                type: video['type'] ?? 'Unknown',
              ))
          .toList();
      return listData;
    } else {
      throw ServerException();
    }
  }
}
