import 'package:flutter/material.dart';

class ProgressGauge extends StatelessWidget {
  final double progress;
  final int currentStep;
  final int totalSteps;

  const ProgressGauge({
    super.key,
    required this.progress,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 12,
        ),

        const SizedBox(height: 15),

        Text(
          '${(progress * 100).toInt()} %',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          '$currentStep / $totalSteps villes téléchargées',
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}