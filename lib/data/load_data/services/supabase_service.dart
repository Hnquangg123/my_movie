import 'package:injectable/injectable.dart';
import 'package:supabase/supabase.dart';

@lazySingleton
@Injectable()
class SupabaseService {
  final SupabaseClient client;

  SupabaseService({required this.client});

  Future<void> insertMovies(List<Map<String, dynamic>> movies) async {
    final response = await client.from('films').insert(movies);
    if (response.error != null) {
      throw Exception('Failed to insert movies');
    }
  }
}
