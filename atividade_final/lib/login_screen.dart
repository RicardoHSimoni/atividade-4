import 'package:flutter/material.dart';
import 'login_widgets.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2)); // Simula login
      setState(() => _isLoading = false);
      
      // Navegar para home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(size: 100),
              const SizedBox(height: 40),
              
              // Email
              LoginTextField(
                label: 'E-mail',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  if (!value.contains('@')) return 'E-mail inválido';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              // Senha
              LoginTextField(
                label: 'Senha',
                controller: _passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              
              // Botão
              PulseButton(
                text: 'Entrar',
                onPressed: _handleLogin,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),
              
              // Links
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text('Criar conta'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/reset-password'),
                    child: const Text('Esqueci a senha'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
  );
 }
}