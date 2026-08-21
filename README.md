# cours_iage_2026

premier projet flutter

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 🌤️ Application Météo Flutter

## 👥 Membres du groupe

Thiane Marie FALL
Rokhaya BOYE

---

## 📱 Présentation du projet

Cette application météo a été développée avec Flutter** et Dart.

Elle permet de récupérer et d'afficher les conditions météorologiques de plusieurs villes en temps réel grâce à l'API **OpenWeather**.

L'utilisateur démarre une expérience de chargement pendant laquelle l'application récupère progressivement les données météo de cinq villes.

Une jauge permet de suivre la progression du téléchargement. Une fois les données récupérées, l'utilisateur peut consulter les résultats, sélectionner une ville pour afficher ses informations détaillées et accéder à sa localisation dans Google Maps.

L'application propose également un **mode clair** et un **mode sombre**.

---

# ✨ Fonctionnalités

L'application possède les fonctionnalités suivantes :

* 🏠 Écran d'accueil
* ▶️ Bouton **« Lancer l'expérience »**
* 📊 Jauge de progression
* 💬 Messages d'attente dynamiques
* 🌍 Récupération des données météo de cinq villes
* 📋 Affichage des résultats météo
* 👆 Sélection d'une ville
* 📄 Page de détail météo
* 🌡️ Affichage de la température
* ☁️ Affichage de la description météo
* 📍 Affichage de la latitude et de la longitude
* 🗺️ Localisation de la ville dans Google Maps
* ☀️ Mode clair
* 🌙 Mode sombre
* 🔄 Bouton **« Recommencer »**
* ⚠️ Gestion des erreurs API
* 🔁 Bouton **« Réessayer »**
* ⬅️ Navigation avec le bouton retour

---

# 🌍 Villes utilisées

L'application récupère les données météorologiques pour les cinq villes suivantes :

1. 🇸🇳 **Dakar**
2. 🇫🇷 **Paris**
3. 🇬🇧 **Londres**
4. 🇺🇸 **New York**
5. 🇯🇵 **Tokyo**

---

# 🛠️ Technologies utilisées

| Technologie         | Utilisation                          |
| ------------------- | ------------------------------------ |
| **Flutter**         | Framework de développement           |
| **Dart**            | Langage de programmation             |
| **Android Studio**  | Environnement de développement       |
| **Windows**         | Environnement d'exécution et de test |
| **Dio**             | Requêtes HTTP                        |
| **Retrofit**        | Déclaration des appels API           |
| **OpenWeather API** | Données météorologiques              |
| **Google Maps**     | Localisation des villes              |
| **url_launcher**    | Ouverture de Google Maps             |

---

# 💻 Environnement de développement

## Android Studio

Le projet a été développé avec **Android Studio**.

Android Studio est utilisé pour :

* écrire le code Dart ;
* organiser les fichiers du projet ;
* gérer les dépendances Flutter ;
* exécuter les commandes Flutter ;
* lancer et déboguer l'application.

## 🖥️ Exécution sur Windows

L'application est exécutée et testée sur **Windows**.

La cible d'exécution utilisée est :

```text
Windows
```

Depuis le terminal d'Android Studio, l'application peut être lancée avec :

```bash
flutter run -d windows
```

---

# 🔑 Configuration de l'API OpenWeather

L'application utilise l'API **OpenWeather** pour récupérer les données météorologiques.

## 1. Création d'un compte

Pour utiliser l'API OpenWeather, il faut créer un compte sur la plateforme OpenWeather.

Après la création du compte, accéder à la section consacrée aux clés API.

## 2. Création de la clé API

Une clé API doit être créée afin d'autoriser l'application à effectuer des requêtes vers OpenWeather.

Cette clé permet à l'application d'accéder aux données météorologiques.

## 3. Utilisation de la clé dans l'application

Dans le code de l'application, une clé API est utilisée lors de l'appel au service météo :

```dart
const apiKey = 'VOTRE_CLE_OPENWEATHER';
```

Il faut remplacer `VOTRE_CLE_OPENWEATHER` par sa propre clé API.

### ⚠️ Sécurité

**La clé API personnelle ne doit jamais être publiée sur GitHub.**

Le README contient uniquement un exemple et ne doit pas contenir une clé personnelle valide.

---

# 🌐 API OpenWeather utilisée

L'application utilise l'endpoint suivant :

```text
https://api.openweathermap.org/data/2.5/weather
```

Les paramètres principaux utilisés sont :

| Paramètre | Description              |
| --------- | ------------------------ |
| `q`       | Nom de la ville          |
| `appid`   | Clé API OpenWeather      |
| `units`   | Unité de température     |
| `lang`    | Langue de la description |

Exemple de paramètres :

```text
q=Dakar
units=metric
lang=fr
```

---

# 🔌 Dio et Retrofit

Le projet utilise **Dio** pour effectuer les requêtes HTTP et **Retrofit** pour organiser les appels à l'API.

Exemple de déclaration de l'API :

```dart
@RestApi(
  baseUrl: 'https://api.openweathermap.org/data/2.5/',
)
abstract class WeatherApi {
  factory WeatherApi(
    Dio dio, {
    String baseUrl,
  }) = _WeatherApi;

  @GET('weather')
  Future<Map<String, dynamic>> getWeather(
    @Query('q') String city,
    @Query('appid') String apiKey,
    @Query('units') String units,
    @Query('lang') String language,
  );
}
```

Les fichiers générés par Retrofit sont créés à l'aide de `build_runner`.

---

# 📦 Modèle des données

Les données récupérées depuis l'API sont utilisées pour construire un objet `WeatherModel`.

Le modèle contient les informations suivantes :

```text
city
temperature
description
latitude
longitude
```

Ces données sont ensuite transmises aux différents écrans de l'application.

---

# 📊 Jauge de progression

Pendant la récupération des données, une jauge indique la progression du téléchargement.

La progression correspond au nombre de villes traitées :

```text
0 %
 ↓
20 %
 ↓
40 %
 ↓
60 %
 ↓
80 %
 ↓
100 %
```

Des messages accompagnent également le chargement :

* **« Nous téléchargeons les données... »**
* **« C'est presque fini... »**
* **« Plus que quelques secondes avant d'avoir le résultat... »**

---

# 🔄 Bouton « Recommencer »

Lorsque les cinq villes ont été chargées et que la jauge atteint **100 %**, le bouton :

```text
Recommencer
```

est affiché.

L'utilisateur peut cliquer dessus pour relancer l'expérience.

La liste des données est réinitialisée et la progression revient à **0 %**.

---

# ⚠️ Gestion des erreurs

L'application prévoit une gestion des erreurs lors des appels à l'API.

Si une ville ne peut pas être récupérée, un message d'erreur est affiché à l'utilisateur.

Exemple :

```text
Impossible de récupérer les données météo pour Paris.
```

Un bouton :

```text
Réessayer
```

permet de relancer la récupération des données.

Cette fonctionnalité permet à l'utilisateur de poursuivre l'utilisation de l'application même lorsqu'un appel API échoue.

---

# 📋 Résultats météo

Après le chargement des données, l'utilisateur peut accéder à la liste des résultats.

Chaque ville affiche notamment :

* le nom de la ville ;
* la température ;
* la description météo ;
* la latitude ;
* la longitude.

L'utilisateur peut cliquer sur une ville pour accéder à sa page de détail.

---

# 📄 Détail d'une ville

Lorsqu'une ville est sélectionnée, une page de détail affiche ses informations météorologiques.

Les informations disponibles sont :

* 🌍 Ville
* 🌡️ Température
* ☁️ Description météo
* 📍 Latitude
* 📍 Longitude

---

# 🗺️ Localisation avec Google Maps

La localisation de chaque ville est déterminée à partir des coordonnées GPS fournies par l'API OpenWeather.

Par exemple, pour Dakar :

```text
Latitude  : 14.6937
Longitude : -17.4441
```

Lorsqu'une ville est sélectionnée, ses coordonnées sont utilisées pour ouvrir sa localisation dans Google Maps.

La localisation dépend donc de la ville sélectionnée :

```text
Dakar     → localisation de Dakar
Paris     → localisation de Paris
Londres   → localisation de Londres
New York  → localisation de New York
Tokyo     → localisation de Tokyo
```

---

# ☀️ Mode clair et 🌙 mode sombre

L'application propose deux modes d'affichage.

## ☀️ Mode clair

Le mode clair propose une interface lumineuse adaptée à une utilisation classique.

## 🌙 Mode sombre

Le mode sombre propose une interface plus adaptée aux environnements peu lumineux.

Les deux modes sont fonctionnels et ont été testés dans l'application.

---

# ⬅️ Navigation et bouton retour

L'application permet à l'utilisateur de revenir en arrière grâce au bouton **Back**.

La navigation principale est organisée autour des écrans suivants :

```text
Accueil
   ↓
Chargement
   ↓
Résultats
   ↓
Détail d'une ville
```

Le bouton retour permet de revenir à l'écran précédent.

---

# 📂 Structure du projet

Le projet est organisé de manière à séparer les modèles, les services, les écrans et les widgets.

```text
lib/
│
├── models/
│   └── weather_model.dart
│
├── services/
│   ├── weather_api.dart
│   └── weather_service.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── loading_screen.dart
│   ├── weather_result_screen.dart
│   └── weather_detail_screen.dart
│
├── widgets/
│   └── progress_gauge.dart
│
└── main.dart
```

---

# 🚀 Installation du projet

## 1. Récupérer le projet

Après la publication sur GitHub :

```bash
git clone URL_DU_DEPOT_GITHUB
```

Puis :

```bash
cd cours_iage_2026
```

## 2. Ouvrir avec Android Studio

Ouvrir le dossier du projet dans **Android Studio**.

## 3. Installer les dépendances

Dans le terminal d'Android Studio :

```bash
flutter pub get
```

## 4. Générer les fichiers Retrofit

Exécuter :

```bash
dart run build_runner build --delete-conflicting-outputs
```

## 5. Configurer OpenWeather

Ajouter sa propre clé API :

```dart
const apiKey = 'VOTRE_CLE_OPENWEATHER';
```

## 6. Vérifier les appareils disponibles

Exécuter :

```bash
flutter devices
```

La cible **Windows** doit apparaître parmi les appareils disponibles.

## 7. Exécuter l'application sur Windows

Exécuter :

```bash
flutter run -d windows
```

Ou sélectionner **Windows** comme appareil cible directement dans Android Studio.

---

# 🧪 Tests réalisés

L'application a été testée sur Windows avec les fonctionnalités suivantes :

* [x] Écran d'accueil
* [x] Lancement de l'expérience
* [x] Chargement des données météo
* [x] Jauge de progression
* [x] Affichage des cinq villes
* [x] Affichage des températures
* [x] Affichage des descriptions météo
* [x] Affichage des coordonnées GPS
* [x] Sélection d'une ville
* [x] Page de détail
* [x] Localisation Google Maps
* [x] Mode clair
* [x] Mode sombre
* [x] Bouton « Recommencer »
* [x] Gestion des erreurs
* [x] Bouton « Réessayer »
* [x] Bouton retour

---

# 🔄 Fonctionnement général

Le fonctionnement de l'application peut être résumé ainsi :

```text
┌──────────────────────────┐
│      Écran d'accueil     │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│ Lancer l'expérience      │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│   Écran de chargement    │
│                          │
│   Jauge de progression   │
│   Messages dynamiques    │
│   Appels API             │
└────────────┬─────────────┘
             │
             ▼
          100 %
             │
      ┌──────┴──────┐
      │             │
      ▼             ▼
Recommencer   Voir les résultats
                    │
                    ▼
             Liste des villes
                    │
                    ▼
             Sélection d'une ville
                    │
                    ▼
              Détail météo
                    │
                    ▼
               Google Maps
```

---

# 📚 Objectifs pédagogiques

Ce projet permet de mettre en pratique plusieurs notions de développement Flutter :

* création d'interfaces avec Flutter ;
* utilisation du langage Dart ;
* navigation entre plusieurs écrans ;
* appels à une API REST ;
* utilisation de Dio ;
* utilisation de Retrofit ;
* traitement des données JSON ;
* création de modèles de données ;
* gestion des erreurs ;
* gestion de la progression ;
* utilisation des coordonnées GPS ;
* ouverture de Google Maps ;
* gestion des thèmes clair et sombre ;
* organisation d'un projet Flutter ;
* utilisation de Git et GitHub.

---

# 🐙 GitHub

Le projet doit être publié dans un dépôt GitHub.

Lien du dépôt :


# 👥 Groupe

### Thiane Marie FALL

Membre du groupe ayant participé au développement de l'application.

### Rokhaya BOYE

Membre du groupe ayant participé au développement de l'application.



# 🎓 Conclusion

Cette application permet de consulter les conditions météorologiques de plusieurs villes en temps réel à travers une interface Flutter.

Elle combine une API météo, une jauge de progression, la navigation entre plusieurs écrans, la gestion des erreurs, Google Maps ainsi que les modes clair et sombre.

Le projet a été développé avec **Android Studio**, puis exécuté et testé sur **Windows**.
