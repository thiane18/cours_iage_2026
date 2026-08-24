class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final double latitude;
  final double longitude;

  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final int pressure;
  final int visibility;
  final DateTime sunrise;
  final DateTime sunset;
  final double? rainVolume;
  final double? snowVolume;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    this.rainVolume,
    this.snowVolume,
  });
}