import '../entities/user.dart';
import '../repo_interface/user_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<void> execute(String email, String password) {
    return repository.login(email, password);
  }
}

class RegisterUseCase {
  final AuthRepository repository;
  
  RegisterUseCase(this.repository);
  
  Future<void> execute(User user) {
    return repository.register(user);
  }
}

class TrackOrderUseCase {
  final AuthRepository repository;
  
  TrackOrderUseCase(this.repository);
  
  Future<void> execute(String orderId) {
    return repository.trackOrder(orderId);
  }
}