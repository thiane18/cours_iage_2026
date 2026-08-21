
import 'weather_api.dart';
import '../models/weather_model.dart';

class WeatherService {
  final WeatherApi api;

  WeatherService(this.api);

  Future<WeatherModel> getWeather({
    required String city,
    required String apiKey,
  }) async {
    final response = await api.getWeather(
      city,
      apiKey,
      'metric',
      'fr',
    );

    final data = response.data as Map<String, dynamic>;

    return WeatherModel(
      city: data['name'] as String,
      temperature: (data['main']['temp'] as num).toDouble(),
      description: data['weather'][0]['description'] as String,
      latitude: (data['coord']['lat'] as num).toDouble(),
      longitude: (data['coord']['lon'] as num).toDouble(),
    );
  }
}