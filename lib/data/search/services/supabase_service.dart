import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable()
class SupabaseService {
  final SupabaseClient _supabaseClient;

  SupabaseService(this._supabaseClient);

  Future<void> storeSearchHistory(String query) async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      await _supabaseClient
          .from('search_queries')
          .upsert({'user_id': user.id, 'query': query});
    }
  }
}
