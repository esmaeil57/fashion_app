import '../../domain/entities/user.dart';
import '../../domain/repo_interface/user_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Future<void> register(User user) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Future<void> trackOrder(String orderId) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
  }
}
