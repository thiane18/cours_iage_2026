import 'package:flutter/material.dart';
import 'loading_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Météo'),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: onToggleTheme,
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            tooltip: isDarkMode
                ? 'Mode clair'
                : 'Mode sombre',
          ),
        ],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDarkMode
                    ? Icons.nightlight_round
                    : Icons.cloud,
                size: 100,
              ),

              const SizedBox(height: 30),

              const Text(
                'Bienvenue dans notre application météo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Découvrez les conditions météorologiques '
                    'de plusieurs villes en temps réel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoadingScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Lancer l’expérience',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}