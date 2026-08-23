import 'dart:math';
import 'package:flutter/material.dart';

class GradientBackground extends StatefulWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? const [Color(0xFF0D1B2E), Color(0xFF1B2A41)]
              : const [Color(0xFF4A90D9), Color(0xFFBFE0F5)],
        ),
      ),
      child: Stack(
        children: [
          // --- Formes flottantes animées, en boucle ---
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _controller.value * 2 * pi;
              return Stack(
                children: [
                  _floatingBlob(
                    top: 60 + sin(t) * 20,
                    left: 40 + cos(t * 0.8) * 30,
                    size: 140,
                    opacity: isDark ? 0.06 : 0.14,
                  ),
                  _floatingBlob(
                    top: 220 + cos(t * 0.6) * 25,
                    right: 30 + sin(t * 0.9) * 20,
                    size: 180,
                    opacity: isDark ? 0.05 : 0.12,
                  ),
                  _floatingBlob(
                    bottom: 100 + sin(t * 0.7) * 20,
                    left: 100 + cos(t * 0.5) * 40,
                    size: 120,
                    opacity: isDark ? 0.07 : 0.10,
                  ),
                ],
              );
            },
          ),

          // --- Contenu réel de l'écran, par-dessus l'animation ---
          widget.child,
        ],
      ),
    );
  }

  Widget _floatingBlob({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required double opacity,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }
}