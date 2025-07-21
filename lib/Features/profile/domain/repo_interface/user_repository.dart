import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(User user);
  Future<void> trackOrder(String orderId);
}