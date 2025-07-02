import 'package:flutter/material.dart';
import '../utils/accessibility.dart';

class MyHomePage extends StatelessWidget {
  // ...existing code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Página Inicial'),
      ),
      body: Center(
        child: Text('Conteúdo da Página Inicial'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.accessibility_new, color: Colors.blue),
              title: Text('Acessibilidade'),
              onTap: () async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Acessibilidade'),
                    content: Text('Deseja ativar o modo leitura do app?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('Não'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Sim'),
                      ),
                    ],
                  ),
                );
                if (result == true) {
                  modoLeituraAtivo = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Modo leitura ativado!')),
                  );
                }
              },
            ),
            // ...existing code...
          ],
        ),
      ),
    );
  }
}