import 'package:flutter/material.dart';
import 'package:projeto_integrador/telas/autenticacao_tela.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AutenticacaoTela(),
    );
  }
}
