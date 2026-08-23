import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/weather_model.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_card.dart';
import '../utils/weather_icons.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailScreen({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(weather.city),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- En-tête : icône + ville + température ---
                Column(
                  children: [
                    Icon(
                      weatherIcon(weather.description),
                      size: 90,
                      color: weatherIconColor(weather.description),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      weather.city,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${weather.temperature.toStringAsFixed(1)} °C',
                      style: const TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // --- Conditions météo ---
                GlassCard(
                  child: Column(
                    children: [
                      const Text(
                        'Conditions météo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        weather.description,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Coordonnées ---
                GlassCard(
                  child: Column(
                    children: [
                      const Text(
                        'Coordonnées',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Latitude : ${weather.latitude}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Longitude : ${weather.longitude}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // --- Bouton Google Maps ---
                ElevatedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse(
                      'https://www.google.com/maps/search/?api=1'
                          '&query=${weather.latitude},${weather.longitude}',
                    );

                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2E7BC4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(Icons.map_rounded),
                  label: const Text('Voir sur Google Maps'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}