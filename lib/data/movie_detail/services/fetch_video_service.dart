import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:my_movie/core/error/exception.dart';
import 'package:my_movie/domain/movie_detail/entities/video.dart';

@singleton
@Injectable()
class FetchVideoService {
  final http.Client client;

  FetchVideoService({required this.client});

  Future<List<Video>> fetchVideos(int movieId) async {
    final String accessToken =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNzdmMTczZDkxOWNhNmFjOTg5ZDZjMzE2MGUxMzBiNSIsIm5iZiI6MTcyOTMwNzIyMS42MDE5OTk4LCJzdWIiOiI2NzEzMjI1NWM2ZTMwNDA5NjE5NWFmNDIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yrZVzxm0Q2g_uHA1AbsjuzejbNwdypXxAN2CNDWmNCw';

    final response = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json;charset=utf-8',
        });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['results'] as List)
          .map((video) => Video.fromJson(video))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
