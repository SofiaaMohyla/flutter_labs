import '../models/user.dart';
import 'i_user_storage.dart';

class AuthManager {
  final IUserStorage _storage;
  User? _currentUser;

  AuthManager(this._storage);

  /// Реєстрація користувача та перевірка унікальності email
  Future<bool> register(User user) async {
    User? existingUser = await _storage.getUser(user.email);
    if (existingUser != null) {
      return false; // Email вже зареєстровано
    }
    await _storage.saveUser(user);
    return true;
  }

  /// Логування користувача
  Future<bool> login(String email, String password) async {
    User? storedUser = await _storage.getUser(email);
    if (storedUser == null) return false;

    if (storedUser.password == password) {
      _currentUser = storedUser;
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
  }

  /// Перевірка, чи є користувач авторизованим
  bool isUserAuthenticated() {
    return _currentUser != null;
  }

  /// Отримати поточного авторизованого користувача
  User? get currentUser => _currentUser;

  /// Отримати всіх користувачів
  Future<List<User>> getAllUsers() async {
    return await _storage.getAllUsers();
  }
}
