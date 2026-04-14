// lib/services/user_service.dart
//
// Responsabilidade única: falar com a API REST (MockAPI).
// Não conhece widgets nem providers — só HTTP.

import 'package:dio/dio.dart';
import '../models/user.dart';

class UserService {
  // -----------------------------------------------------------------------
  // IMPORTANTE: troque pela URL do SEU projeto no MockAPI
  // Exemplo: https://67f123abc0a14684abcde.mockapi.io/api/v1
  // Passos para criar:
  //   1. Acesse https://mockapi.io e crie uma conta grátis
  //   2. Crie um novo projeto
  //   3. Adicione um resource chamado "users" com os campos:
  //      name (String), email (String), avatar (String)
  //   4. Copie a URL base e cole aqui ↓
  // -----------------------------------------------------------------------
  static const String _baseUrl =
      'https://69dd6f1584f912a264050e8b.mockapi.io/api/v1/';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // READ - lista todos os usuários
  Future<List<User>> getUsers() async {
    final response = await _dio.get('/users');
    final List<dynamic> data = response.data;
    return data.map((json) => User.fromJson(json)).toList();
  }

  // READ - busca um usuário pelo id
  Future<User> getUserById(String id) async {
    final response = await _dio.get('/users/$id');
    return User.fromJson(response.data);
  }

  // CREATE - cria um novo usuário
  Future<User> createUser(User user) async {
    final response = await _dio.post('/users', data: user.toJson());
    return User.fromJson(response.data);
  }

  // UPDATE - atualiza um usuário existente
  Future<User> updateUser(User user) async {
    final response = await _dio.put('/users/${user.id}', data: user.toJson());
    return User.fromJson(response.data);
  }

  // DELETE - remove um usuário pelo id
  Future<void> deleteUser(String id) async {
    await _dio.delete('/users/$id');
  }
}
