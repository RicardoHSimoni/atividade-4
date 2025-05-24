import 'package:atividade_final/screens/forgot_password_screen.dart';
import 'package:atividade_final/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:atividade_final/screens/home_screen.dart';
import '../database/user_dao.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _lembrarUsuario = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _carregarEmailSalvo();
  }

  void _carregarEmailSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    final emailSalvo = prefs.getString('email_salvo');
    if (emailSalvo != null) {
      final user = await UserDao.getUserByEmail(emailSalvo);
      if (user != null) {
        // Login automático
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();


  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final senha = _senhaController.text;

      final user = await UserDao.getUserByEmail(email);

      if (user == null || user.password != senha) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciais inválidas')),
        );
        return;
      }

      if (_lembrarUsuario) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email_salvo', user.email);
      }

      // Se usuário e senha estiverem corretos
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: user),
        ),
      );
    }
  }

  void _goToRegister() {
    // Navegar para a tela de registro
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela de Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe seu e-mail';
                  }
                  if (!value.contains('@')) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Entrar'),
              ),
              TextButton(
                onPressed: _goToRegister,
                child: const Text('Registrar-se'),
              ),
              TextButton(
                onPressed: _goToForgotPassword,
                child: const Text('Esqueci minha senha'),
              ),
              CheckboxListTile(
                title: const Text('Lembrar usuário'),
                value: _lembrarUsuario,
                onChanged: (value) {
                setState(() {
                  _lembrarUsuario = value ?? false;
                });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}