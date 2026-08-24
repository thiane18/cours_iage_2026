/// Convertit un angle en degrés (0-360) en point cardinal (16 directions).
String windDirectionLabel(int degrees) {
  const directions = [
    'N', 'NNE', 'NE', 'ENE',
    'E', 'ESE', 'SE', 'SSE',
    'S', 'SSO', 'SO', 'OSO',
    'O', 'ONO', 'NO', 'NNO',
  ];

  final index = ((degrees + 11.25) / 22.5).floor() % 16;
  return directions[index];
}