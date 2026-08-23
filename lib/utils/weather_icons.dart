import 'package:flutter/material.dart';

IconData weatherIcon(String description) {
  final d = description.toLowerCase();

  if (d.contains('pluie') || d.contains('bruine')) return Icons.water_drop_rounded;
  if (d.contains('orage')) return Icons.thunderstorm_rounded;
  if (d.contains('neige')) return Icons.ac_unit_rounded;
  if (d.contains('brum') || d.contains('brouillard')) return Icons.foggy;
  if (d.contains('peu nuageux')) return Icons.wb_cloudy_rounded;
  if (d.contains('nuageux') || d.contains('couvert') || d.contains('nuage')) {
    return Icons.cloud_rounded;
  }
  if (d.contains('dégagé') || d.contains('clair')) return Icons.wb_sunny_rounded;

  return Icons.wb_sunny_rounded;
}

Color weatherIconColor(String description) {
  final d = description.toLowerCase();

  if (d.contains('dégagé') || d.contains('clair')) return const Color(0xFFFFB300);
  if (d.contains('pluie') || d.contains('orage')) return const Color(0xFF64B5F6);
  if (d.contains('neige')) return const Color(0xFFE1F5FE);

  return Colors.white;
}