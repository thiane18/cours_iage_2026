import 'package:cours_iage_2026/screens/weather_result_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/progress_gauge.dart';
import '../models/weather_model.dart';
import '../services/weather_api.dart';
import '../services/weather_service.dart';
import 'package:dio/dio.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progress = 0.0;

  int messageIndex = 0;

  bool isFinished = false;

  String? errorMessage;

  final List<String> messages = [
    'Nous téléchargeons les données...',
    "C'est presque fini...",
    "Plus que quelques secondes avant d'avoir le résultat...",
  ];

  final List<String> cities = [
    'Dakar',
    'Paris',
    'Londres',
    'New York',
    'Tokyo',
  ];

  final List<WeatherModel> weatherList = [];

  late WeatherService weatherService;

  @override
  void initState() {
    super.initState();

    final dio = Dio();
    final api = WeatherApi(dio);

    weatherService = WeatherService(api);

    loadWeather();
  }

  Future<void> loadWeather() async {
    const apiKey = '3df12ce273dad35fd72b4025a101218a';

    setState(() {
      progress = 0.0;
      messageIndex = 0;
      isFinished = false;
      errorMessage = null;
      weatherList.clear();
    });

    for (int i = 0; i < cities.length; i++) {
      try {
        final weather = await weatherService.getWeather(
          city: cities[i],
          apiKey: apiKey,
        );

        weatherList.add(weather);

        if (!mounted) return;

        setState(() {
          progress = (i + 1) / cities.length;
          messageIndex =
              (messageIndex + 1) % messages.length;
        });
      } catch (e) {
        debugPrint(
          'Erreur pour ${cities[i]} : $e',
        );

        if (!mounted) return;

        setState(() {
          errorMessage =
          'Impossible de récupérer les données météo pour ${cities[i]}.';
        });

        return;
      }
    }

    if (!mounted) return;

    if (weatherList.length == cities.length) {
      setState(() {
        progress = 1.0;
        isFinished = true;
      });
    }
  }

  void showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherResultScreen(
          weatherList: weatherList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chargement'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Préparation des données météo...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // Affichage de l'erreur
              if (errorMessage != null) ...[
                const Icon(
                  Icons.error_outline,
                  size: 60,
                ),

                const SizedBox(height: 15),

                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: loadWeather,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ]

              // Jauge pendant le chargement
              else if (!isFinished)
                ProgressGauge(
                  progress: progress,
                  currentStep: weatherList.length,
                  totalSteps: cities.length,
                )

              // Bouton après 100 %
              else
                ElevatedButton.icon(
                  onPressed: loadWeather,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Recommencer'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              if (errorMessage == null)
                Text(
                  isFinished
                      ? 'Téléchargement terminé !'
                      : messages[messageIndex],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

              const SizedBox(height: 20),

              // Accéder aux résultats
              if (isFinished)
                OutlinedButton(
                  onPressed: showResults,
                  child: const Text(
                    'Voir les résultats météo',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}