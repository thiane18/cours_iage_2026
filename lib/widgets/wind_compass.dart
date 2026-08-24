import 'dart:math';
import 'package:flutter/material.dart';

/// Petite boussole visuelle indiquant la direction du vent.
class WindCompass extends StatelessWidget {
  final int degrees;

  const WindCompass({super.key, required this.degrees});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
          ),
          const Positioned(top: 4, child: _Cardinal('N')),
          const Positioned(bottom: 4, child: _Cardinal('S')),
          const Positioned(left: 6, child: _Cardinal('O')),
          const Positioned(right: 6, child: _Cardinal('E')),
          Transform.rotate(
            angle: degrees * pi / 180,
            child: const Icon(
              Icons.navigation_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _Cardinal extends StatelessWidget {
  final String label;

  const _Cardinal(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}