import 'package:dio/dio.dart';
import 'services/weather_api.dart';
import 'services/weather_service.dart';


Future<void> testWeather() async {
  const apiKey = String.fromEnvironment('OPEN_WEATHER_API_KEY');

  final dio = Dio();

  final api = WeatherApi(dio);

  final service = WeatherService(api);

  try {
    final weather = await service.getWeather(
      city: 'Dakar',
      apiKey: apiKey,
    );

    print('Ville : ${weather.city}');
    print('Température : ${weather.temperature} °C');
    print('Description : ${weather.description}');
    print('Latitude : ${weather.latitude}');
    print('Longitude : ${weather.longitude}');
  } catch (e) {
    print('Erreur météo : $e');
  }
}