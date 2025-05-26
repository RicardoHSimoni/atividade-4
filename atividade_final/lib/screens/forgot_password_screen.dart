import 'package:flutter/material.dart';
import '../database/user_dao.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  void _recuperarSenha() async {
    final email = _emailController.text;
    final user = await UserDao.getUserByEmail(email);
    if (!mounted) return;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail não encontrado')),
      );
      return;
    }
    // Simulação de envio de nova senha ou dica
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Senha ou dica enviada para $email')),
    );
    // Voltar para a tela de login
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperação de Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Informe seu e-mail'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _recuperarSenha,
              child: const Text('Recuperar Senha'),
            ),
          ],
        ),
      ),
    );
  }
}