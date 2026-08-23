import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_card.dart';
import '../utils/weather_icons.dart';
import 'weather_detail_screen.dart';

class WeatherResultScreen extends StatelessWidget {
  final List<WeatherModel> weatherList;

  const WeatherResultScreen({
    super.key,
    required this.weatherList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Résultats météo'),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: weatherList.length,
            itemBuilder: (context, index) {
              final weather = weatherList[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherDetailScreen(
                            weather: weather,
                          ),
                        ),
                      );
                    },
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_city,
                                size: 28,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  weather.city,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                '${weather.temperature.toStringAsFixed(1)} °C',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Row(
                            children: [
                              Icon(
                                weatherIcon(weather.description),
                                size: 22,
                                color: weatherIconColor(weather.description),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                weather.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Divider(color: Colors.white.withOpacity(0.3)),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              const Icon(
                                Icons.my_location,
                                size: 18,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Latitude : ${weather.latitude}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Longitude : ${weather.longitude}',
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Voir les détails →',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}