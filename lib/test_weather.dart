import 'package:dio/dio.dart';
import 'services/weather_api.dart';
import 'services/weather_service.dart';


Future<void> testWeather() async {
  const apiKey = '7ab1f7a99d1ed1bdd0d77b9e36c122bf';

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