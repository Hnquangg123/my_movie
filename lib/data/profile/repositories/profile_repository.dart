import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/profile/repositories/i_profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final SupabaseClient _supabaseClient;

  ProfileRepository(this._supabaseClient);

  @override
  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final User? user = _supabaseClient.auth.currentUser;

      final response =
          await _supabaseClient.from('profiles').select().eq('id', user!.id).single();
      return response;
    } catch (e) {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Future<void> updateUserProfile(String name, String phone) async {
    try {
      final User? user = _supabaseClient.auth.currentUser;

      await _supabaseClient
          .from('profiles')
          .update({'username': name, 'phone': phone}).eq('id', user!.id);
    } catch (e) {
      throw Exception('Failed to update profile');
    }
  }
}
