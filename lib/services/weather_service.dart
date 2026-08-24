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

    final int timezoneOffset = data['timezone'] as int;

    DateTime toLocalCityTime(int unixSeconds) {
      return DateTime.fromMillisecondsSinceEpoch(
        (unixSeconds + timezoneOffset) * 1000,
        isUtc: true,
      );
    }

    return WeatherModel(
      city: data['name'] as String,
      temperature: (data['main']['temp'] as num).toDouble(),
      description: data['weather'][0]['description'] as String,
      latitude: (data['coord']['lat'] as num).toDouble(),
      longitude: (data['coord']['lon'] as num).toDouble(),

      feelsLike: (data['main']['feels_like'] as num).toDouble(),
      tempMin: (data['main']['temp_min'] as num).toDouble(),
      tempMax: (data['main']['temp_max'] as num).toDouble(),
      humidity: data['main']['humidity'] as int,
      windSpeed: (data['wind']['speed'] as num).toDouble(),
      windDirection: (data['wind']['deg'] as num?)?.toInt() ?? 0,
      pressure: data['main']['pressure'] as int,
      visibility: (data['visibility'] as int?) ?? 10000,
      sunrise: toLocalCityTime(data['sys']['sunrise'] as int),
      sunset: toLocalCityTime(data['sys']['sunset'] as int),

      rainVolume: data['rain'] != null
          ? (data['rain']['1h'] as num?)?.toDouble()
          : null,
      snowVolume: data['snow'] != null
          ? (data['snow']['1h'] as num?)?.toDouble()
          : null,
    );
  }
}