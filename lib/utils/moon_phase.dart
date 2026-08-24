/// Calcule la phase de la lune actuelle par un calcul mathématique.
/// Aucun appel API nécessaire : la position de la lune se déduit
/// simplement de la date, grâce à la durée connue du cycle lunaire
/// (environ 29,53 jours entre deux nouvelles lunes).
class MoonPhaseInfo {
  final String name;
  final String emoji;
  final int illumination; // pourcentage 0-100

  MoonPhaseInfo({
    required this.name,
    required this.emoji,
    required this.illumination,
  });
}

MoonPhaseInfo calculateMoonPhase(DateTime date) {
  // Une nouvelle lune connue et confirmée, utilisée comme point de départ.
  final reference = DateTime.utc(1970, 1, 7, 20, 35);

  // Durée d'un cycle lunaire complet, en secondes (~29,53 jours).
  const synodicMonthSeconds = 2551443;

  final secondsSinceReference =
      date.toUtc().difference(reference).inSeconds % synodicMonthSeconds;

  final normalizedSeconds = secondsSinceReference < 0
      ? secondsSinceReference + synodicMonthSeconds
      : secondsSinceReference;

  // Position dans le cycle : 0.0 = nouvelle lune, 0.5 = pleine lune.
  final position = normalizedSeconds / synodicMonthSeconds;

  // Illumination approximative : maximale à la pleine lune.
  final illumination = ((1 - (2 * position - 1).abs()) * 100).round();

  String name;
  String emoji;

  if (position < 0.03 || position > 0.97) {
    name = 'Nouvelle lune';
    emoji = '🌑';
  } else if (position < 0.22) {
    name = 'Premier croissant';
    emoji = '🌒';
  } else if (position < 0.28) {
    name = 'Premier quartier';
    emoji = '🌓';
  } else if (position < 0.47) {
    name = 'Lune gibbeuse croissante';
    emoji = '🌔';
  } else if (position < 0.53) {
    name = 'Pleine lune';
    emoji = '🌕';
  } else if (position < 0.72) {
    name = 'Lune gibbeuse décroissante';
    emoji = '🌖';
  } else if (position < 0.78) {
    name = 'Dernier quartier';
    emoji = '🌗';
  } else {
    name = 'Dernier croissant';
    emoji = '🌘';
  }

  return MoonPhaseInfo(name: name, emoji: emoji, illumination: illumination);
}