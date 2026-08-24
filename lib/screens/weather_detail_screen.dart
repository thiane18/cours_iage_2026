import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/weather_model.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/wind_compass.dart';
import '../utils/weather_icons.dart';
import '../utils/wind_utils.dart';
import '../utils/moon_phase.dart';

class WeatherDetailScreen extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDetailScreen({
    super.key,
    required this.weather,
  });

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final moon = calculateMoonPhase(DateTime.now());

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
                    Text(
                      'Ressenti ${weather.feelsLike.toStringAsFixed(1)} °C',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
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
                      const SizedBox(height: 10),
                      Text(
                        'Min ${weather.tempMin.toStringAsFixed(1)}° · '
                            'Max ${weather.tempMax.toStringAsFixed(1)}°',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Vent (avec boussole) ---
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vent',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          WindCompass(degrees: weather.windDirection),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(weather.windSpeed * 3.6).toStringAsFixed(1)} km/h',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${windDirectionLabel(weather.windDirection)} · ${weather.windDirection}°',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Détails (humidité, pression, visibilité) ---
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Détails',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _InfoRow(
                        icon: Icons.water_drop_outlined,
                        label: 'Humidité',
                        value: '${weather.humidity} %',
                      ),
                      _InfoRow(
                        icon: Icons.speed_rounded,
                        label: 'Pression',
                        value: '${weather.pressure} hPa',
                      ),
                      _InfoRow(
                        icon: Icons.visibility_outlined,
                        label: 'Visibilité',
                        value:
                        '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Lever / coucher du soleil ---
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Soleil',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _InfoRow(
                        icon: Icons.wb_twilight_rounded,
                        label: 'Lever',
                        value: _formatTime(weather.sunrise),
                      ),
                      _InfoRow(
                        icon: Icons.nights_stay_outlined,
                        label: 'Coucher',
                        value: _formatTime(weather.sunset),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Lune (calculée, sans API) ---
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lune',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Text(moon.emoji, style: const TextStyle(fontSize: 48)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  moon.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Illumination ${moon.illumination} %',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Précipitations ---
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Précipitations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (weather.rainVolume != null)
                        _InfoRow(
                          icon: Icons.water_drop_rounded,
                          label: 'Pluie (dernière heure)',
                          value: '${weather.rainVolume} mm',
                        ),
                      if (weather.snowVolume != null)
                        _InfoRow(
                          icon: Icons.ac_unit_rounded,
                          label: 'Neige (dernière heure)',
                          value: '${weather.snowVolume} mm',
                        ),
                      if (weather.rainVolume == null && weather.snowVolume == null)
                        const Text(
                          'Aucune précipitation actuellement',
                          style: TextStyle(color: Colors.white70),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // --- Coordonnées ---
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      _InfoRow(
                        icon: Icons.my_location,
                        label: 'Latitude',
                        value: '${weather.latitude}',
                      ),
                      _InfoRow(
                        icon: Icons.location_on,
                        label: 'Longitude',
                        value: '${weather.longitude}',
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

/// Petite ligne "icône + libellé + valeur", réutilisée dans chaque carte
/// pour garder une présentation cohérente sur tout l'écran.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white70),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}