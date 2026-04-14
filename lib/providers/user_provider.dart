// lib/providers/user_provider.dart
//
// Ponte entre a UI e o Service.
// Guarda o estado (lista de usuários, loading, erro) e notifica a UI.

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service = UserService();

  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters públicos (somente leitura para a UI)
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // -----------------------------------------------------------------------
  // Helpers privados para controlar estado de loading/erro
  // -----------------------------------------------------------------------

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // -----------------------------------------------------------------------
  // Operações CRUD
  // -----------------------------------------------------------------------

  // READ - carrega todos os usuários da API
  Future<void> fetchUsers() async {
    _setLoading(true);
    _setError(null);
    try {
      _users = await _service.getUsers();
    } catch (e) {
      _setError('Erro ao carregar usuários: $e');
    } finally {
      _setLoading(false);
    }
  }

  // CREATE - adiciona um novo usuário
  Future<bool> addUser(User user) async {
    _setLoading(true);
    _setError(null);
    try {
      final newUser = await _service.createUser(user);
      _users.add(newUser);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erro ao criar usuário: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // UPDATE - atualiza um usuário existente
  Future<bool> editUser(User user) async {
    _setLoading(true);
    _setError(null);
    try {
      final updated = await _service.updateUser(user);
      final index = _users.indexWhere((u) => u.id == updated.id);
      if (index != -1) {
        _users[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _setError('Erro ao atualizar usuário: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // DELETE - remove um usuário da lista e da API
  Future<bool> removeUser(String id) async {
    _setLoading(true);
    _setError(null);
    try {
      await _service.deleteUser(id);
      _users.removeWhere((u) => u.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Erro ao deletar usuário: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
