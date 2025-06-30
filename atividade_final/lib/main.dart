import 'dart:async';
import 'package:flutter/material.dart';
import 'theme_controller.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyGimApp());
}

final ThemeController themeController = ThemeController();

// APP PRINCIPAL
class MyGimApp extends StatelessWidget {
  const MyGimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeData>(
      valueListenable: themeController.themeNotifier,
      builder: (_, theme, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyGimApp',
          theme: theme,
          home: SplashScreenFlutter(), // ou SplashScreenFlutter, dependendo da navegação
        );
      },
    );
  }
}

// SPLASH SCREEN COM FUNDO RESPONSIVO
class SplashScreenFlutter extends StatefulWidget {
  const SplashScreenFlutter({super.key});

  @override
  State<SplashScreenFlutter> createState() => _SplashScreenFlutterState();
}

class _SplashScreenFlutterState extends State<SplashScreenFlutter> {
  bool _showLogo = false;
  bool _isDayTime = true;

  @override
  void initState() {
    super.initState();
    _configureSplash();
  }

  Future<void> _configureSplash() async {
    _checkTimeOfDay();

    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) setState(() => _showLogo = true);

    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  void _checkTimeOfDay() {
    final hour = DateTime.now().hour;
    setState(() {
      _isDayTime = hour >= 6 && hour < 18; // Das 6h às 18h é considerado dia
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _isDayTime
                ? [Colors.lightBlue.shade200, Colors.white]
                : [Colors.indigo.shade900, Colors.black87],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _showLogo ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: Image.asset(
              'assets/logo.png',
              width: 160,
            ),
          ),
        ),
      ),
    );
  }
}

// TELA DE ONBOARDING COM BOTÃO PULAR E SWIPE
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {"image": "assets/image1.jpg", "text": "Seu treino, sua jornada"},
    {"image": "assets/image2.jpg", "text": "Acompanhe seu progresso"},
    {"image": "assets/image3.png", "text": "Alcance suas metas"},
  ];

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        double value = 1.0;
                        double rotation = 0.0;
                        if (_controller.position.haveDimensions) {
                          value = ((_controller.page ?? _controller.initialPage) - index).toDouble();
                          // Escala mais agressiva
                          double scale = (1 - (value.abs() * 0.5)).clamp(0.5, 1.0);
                          // Rotação mais perceptível
                          rotation = value * 0.5; // 0.5 radianos ~28 graus
                          return Opacity(
                            opacity: scale,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scale(scale)
                                ..rotateZ(rotation),
                              child: child,
                            ),
                          );
                        }
                        return child!;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(onboardingData[index]['image']!, height: 300),
                          SizedBox(height: 20),
                          Text(
                            onboardingData[index]['text']!,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _currentPage > 0 ? _prevPage : null,
                    ),
                    Row(
                      children: List.generate(
                        onboardingData.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 12 : 8,
                          height: _currentPage == index ? 12 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    _currentPage == onboardingData.length - 1
                        ? ElevatedButton(
                            onPressed: _skip,
                            child: Text("Começar"),
                          )
                        : IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: _nextPage,
                          ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _skip,
              child: Text(
                "Pular",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: themeController.currentTheme.brightness == Brightness.dark
          ? const Color.fromARGB(255, 23, 24, 31) : Colors.white,
    );
  }
}
