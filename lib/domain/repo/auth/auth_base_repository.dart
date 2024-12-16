abstract class AuthBaseRepository {
  Future<void> sendOTP(Map<String, dynamic> data);

  Future<void> verifyOTP(Map<String, dynamic> data);

  Future<void> register(Map<String, dynamic> data);

  Future<void> fetchUserDetail(String id);

  Future<void> updateUser(Map<String, dynamic> data);
}
