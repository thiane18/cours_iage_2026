import 'package:flutter/material.dart';
import '../models/weather_model.dart';
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
      appBar: AppBar(
        title: const Text('Résultats météo'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weatherList.length,
        itemBuilder: (context, index) {
          final weather = weatherList[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
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
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city,
                          size: 30,
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            weather.city,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          '${weather.temperature.toStringAsFixed(1)} °C',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        const Icon(
                          Icons.cloud,
                          size: 22,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          weather.description,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const Divider(),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(
                          Icons.my_location,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            'Latitude : ${weather.latitude}',
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
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            'Longitude : ${weather.longitude}',
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}