// lib/models/user.dart
//
// Representa um usuário retornado pela MockAPI.
// A MockAPI gera automaticamente o campo "id" como String.

class User {
  final String? id;
  final String name;
  final String email;
  final String avatar;

  User({
    this.id,
    required this.name,
    required this.email,
    this.avatar = '',
  });

  // Converte JSON (vindo da API) para objeto Dart
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  // Converte objeto Dart para JSON (para enviar à API)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }

  // Cria uma cópia com campos alterados (útil no update)
  User copyWith({String? id, String? name, String? email, String? avatar}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }
}
