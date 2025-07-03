import 'package:atividade_final/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'package:expandable_cardview/expandable_cardview.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final buttonTheme = ElevatedButton.styleFrom(
    backgroundColor: isDark ? Colors.deepPurple : Colors.blue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    ),
    textStyle: const TextStyle(fontWeight: FontWeight.bold),
  );

  return Theme(
    data: Theme.of(context).copyWith(
    textTheme: Theme.of(context).textTheme.apply(
      fontFamily: 'Times New Roman',
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: buttonTheme.copyWith(
      textStyle: MaterialStateProperty.all(
      const TextStyle(fontFamily: 'Times New Roman', fontWeight: FontWeight.bold),
      ),
    )),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
      foregroundColor: isDark ? Colors.amber : Colors.blue,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
      foregroundColor: isDark ? Colors.amber : Colors.blue,
      ),
    ),
    ),
    child: Scaffold(
    appBar: AppBar(
      title: const Text('My Gym App'),
      actions: [
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
    body: SizedBox.expand(
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
        Expanded(
        child: Center(
          child: SizedBox(
          width: 450,
            child: SingleChildScrollView(
            child: Column(
            children: [
              ExpandableCard(
              title: 'Treino Superiores',
              description: 'Treino de força para membros superiores',
              button2Value: 'Comece a treinar',
              sectionRowCount: 1,
              sectionRowTitles: const ['Exercícios'],
              totalText: 3,
              backgroundColor: isDark ? Colors.grey[800] : Colors.white,
              elevation: 4.0,
              button2Elevation: 5.0,
              button2Color: isDark ? Colors.deepPurple : Colors.blue,
              button1TextColor: isDark ? Colors.amber : Colors.blue,
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
                title: Text('Hora de fortalecer os braços!'),
                content: Text('Vamos treinar membros superiores!'),
                actions: [
                TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Bora!!!'),
                ),
                ],
              ),
              );
              },
              ),
              SizedBox(height: 16),
              ExpandableCard(
              title: 'Treino Inferiores',
              description: 'Treino de força para membros inferiores',
              button2Value: 'Comece a treinar',
              sectionRowCount: 1,
              sectionRowTitles: const ['Exercícios'],
              totalText: 3,
              backgroundColor: isDark ? Colors.grey[800] : Colors.white,
              elevation: 4.0,
              button2Elevation: 5.0,
              button2Color: isDark ? Colors.deepPurple : Colors.blue,
              button1TextColor: isDark ? Colors.amber : Colors.blue,
              button2BorderRadius: 5.0,
              cardBorderRadius: 10,
              sectionRowData: const {
              'Exercícios': ['Agachamento 4x12','Leg press 4x15','Cadeira extensora 4x15'],
              },
              textButtonActionFirst: 'Detalhes',
              textButtonActionSecond: 'Fechar',
              onPressedButton2: () {
              showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Hora de fortalecer as pernas!'),
                content: Text('Vamos treinar membros inferiores!'),
                actions: [
                TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Bora!'),
                ),
                ],
              ),
              );
              },
              ),
              SizedBox(height: 16),
              ExpandableCard(
              title: 'Cardio',
              description: 'Treino para melhorar o condicionamento cardiovascular',
              button2Value: 'Comece a treinar',
              sectionRowCount: 1,
              sectionRowTitles: const ['Exercícios'],
              totalText: 3,
              backgroundColor: isDark ? Colors.grey[800] : Colors.white,
              elevation: 4.0,
              button2Elevation: 5.0,
              button2Color: isDark ? Colors.deepPurple : Colors.blue,
              button1TextColor: isDark ? Colors.amber : Colors.blue,
              button2BorderRadius: 5.0,
              cardBorderRadius: 10,
              sectionRowData: const {
                'Exercícios': [
                'Corrida na esteira 20min',
                'Bicicleta ergométrica 15min',
                'Pular corda 10min'
                ],
              },
              textButtonActionFirst: 'Detalhes',
              textButtonActionSecond: 'Fechar',
              onPressedButton2: () {
                showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Vamos acelerar o coração!'),
                  content: Text('Hora do treino cardio!'),
                  actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Vamos lá!'),
                  ),
                  ],
                ),
                );
              },
              ),
            ],
            ),
            ),
          ),
        ),
        ),
      ],
      ),
    ),
    ),
  );
  }
}