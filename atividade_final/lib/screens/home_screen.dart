import 'package:atividade_final/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'package:expandable_cardview/expandable_cardview.dart';
import '../utils/accessibility.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  final bool showLoginSuccess;

  const HomeScreen({super.key, required this.user, this.showLoginSuccess = false});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    if (widget.showLoginSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário logado com sucesso')),
        );
      });
    }
    if (modoLeituraAtivo) {
      _lerConteudo();
    }
  }

  Future<void> _lerConteudo() async {
    // Monte aqui o texto com todo o conteúdo da tela
    String texto = '''
Bem-vindo, ${widget.user.email}.
Esta é a tela inicial do aplicativo.

Aqui estão suas opções:
1. Ver perfil
2. Configurações
3. Sair

Toque em uma das opções para continuar.
''';
    await flutterTts.speak(texto);
  }

  Future<void> _logout() async {
    // Limpa o e-mail salvo nas preferências
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email_salvo');
    // Redireciona para a tela de login
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = themeController.currentTheme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gim App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
           IconButton(
             icon: Icon(isDark ? Icons.wb_sunny : Icons.nights_stay),
             onPressed: () {
               themeController.toggleTheme();
             },
           ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Configurações'),
              onTap: () {
                // Ação ao clicar em Configurações
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Bem vindo ${widget.user.email}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              width: 450,
              height: 350,
              child: ExpandableCard(
                title: 'Treino Superiores',
                description: 'Treino de força para membros superiores',
                button2Value: 'Comece a treinar',
                sectionRowCount: 1,
                sectionRowTitles: const ['Exercícios'],
                totalText: 3,
                backgroundColor: isDark ? Colors.grey[800] : Colors.white,
                elevation: 4.0,
                button2Elevation: 5.0,
                button2Color: Colors.blue,
                button1TextColor: Colors.black,
                button2BorderRadius: 5.0,
                cardBorderRadius: 10,
                sectionRowData: const {
                  'Exercícios': ['Rosca direta 4x15','Supino com halteres 4x15','Voador 4x15'],
                },
                textButtonActionFirst: 'Detalhes',
                textButtonActionSecond: 'Fechar',
                onPressedButton2: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('VAMBORA PORRA AQUI NÓIS CONTRÓI FIBRA'),
                      content: Text('VAMBORA CUMPADI'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('BIRL!!!'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}