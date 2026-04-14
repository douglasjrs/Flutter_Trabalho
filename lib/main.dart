// lib/main.dart
//
// Ponto de entrada do aplicativo.
// Registra o UserProvider no topo da árvore de widgets
// e passa o GoRouter para MaterialApp.router.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      // MaterialApp.router integra o GoRouter ao Flutter
      child: MaterialApp.router(
        title: 'Flutter_Trabalho_Usuários',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: appRouter, // GoRouter assume o controle de navegação
      ),
    );
  }
}
