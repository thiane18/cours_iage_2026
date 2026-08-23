import 'package:flutter/material.dart';
import 'loading_screen.dart';
import '../widgets/gradient_background.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Météo'),
        actions: [
          IconButton(
            onPressed: onToggleTheme,
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: isDarkMode ? 'Mode clair' : 'Mode sombre',
          ),
        ],
      ),

      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    child: Icon(
                      isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                      size: 90,
                      color: isDarkMode ? Colors.white : const Color(0xFFFFB300),
                    ),
                  ),

                  const SizedBox(height: 32),

                  const Text(
                    'Bienvenue dans notre application météo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Découvrez les conditions météorologiques '
                        'de plusieurs villes en temps réel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),

                  const SizedBox(height: 48),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoadingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2E7BC4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Lancer l’expérience'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}