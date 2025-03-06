import 'package:injectable/injectable.dart';
import 'package:my_movie/data/recommendation/services/open_ai_service.dart';
import 'package:my_movie/domain/recommendation/entities/movie.dart';
import 'package:my_movie/domain/recommendation/entities/recommendation_movie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@singleton
@Injectable()
class RecommendationService {
  final SupabaseClient _supabase;
  final OpenAIService _openAIService;

  RecommendationService(this._supabase, this._openAIService);

  Future<List<RecommendationMovie>> getRecommendedMovies() async {
    final User? user = _supabase.auth.currentUser;

    // print(user!.id);

    final searchResults = await _supabase
        .from('search_queries')
        .select('query')
        .eq('user_id', user!.id)
        .order('created_at', ascending: false)
        .limit(5);

    print("1. Search Result: $searchResults");

    if (searchResults.isEmpty) return [];

    List<List<double>> embeddings = [];
    for (var search in searchResults) {
      final queryText = search['query'] as String;
      final embedding = await _openAIService.generateEmbedding(queryText);
      // print(embedding);
      if (embedding.isNotEmpty) embeddings.add(embedding);
    }

    print("2. Embedding: $embeddings");

    final avgEmbedding = _computeAverageEmbedding(embeddings);

    print("3. Embedding after compute avegare: $avgEmbedding");

    final data = await _supabase.rpc(
      'match_movies',
      params: {'user_embedding': avgEmbedding},
    ).limit(10);

    final List<Map<String, dynamic>> movies =
        List<Map<String, dynamic>>.from(data);

    print("4. Recommendation Movies: $movies");

    return movies.map((movie) => RecommendationMovie.fromJson(movie)).toList();
  }

  List<double> _computeAverageEmbedding(List<List<double>> embeddings) {
    int vectorSize = embeddings[0].length;
    List<double> avgEmbedding = List.filled(vectorSize, 0.0);

    for (var emb in embeddings) {
      for (int i = 0; i < vectorSize; i++) {
        avgEmbedding[i] += emb[i];
      }
    }

    // Divide by number of embeddings to get the average
    for (int i = 0; i < vectorSize; i++) {
      avgEmbedding[i] /= embeddings.length;
    }

    return avgEmbedding;
  }
}
