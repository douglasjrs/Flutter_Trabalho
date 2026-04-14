// lib/router.dart
//
// Configuração centralizada de rotas com GoRouter.
// Todas as rotas do app ficam aqui — fácil de expandir.

import 'package:go_router/go_router.dart';
import 'models/user.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/add_edit_screen.dart';

// Nomes das rotas (constantes evitam typos)
class AppRoutes {
  static const home = '/';
  static const addUser = '/users/new';
  static const editUser = '/users/edit';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    // Tela inicial — lista de usuários
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),

    // Tela de criação — sem parâmetros
    GoRoute(
      path: AppRoutes.addUser,
      builder: (context, state) => const AddEditScreen(),
    ),

    // Tela de edição — recebe o objeto User via `extra`
    GoRoute(
      path: AppRoutes.editUser,
      builder: (context, state) {
        final user = state.extra as User;
        return AddEditScreen(user: user);
      },
    ),
  ],
);
