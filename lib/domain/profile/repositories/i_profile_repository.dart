abstract class IProfileRepository {
  Future<Map<String, dynamic>> fetchUserProfile();
  Future<void> updateUserProfile(String name, String email);
}
