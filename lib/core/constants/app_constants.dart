/// App-wide constant values
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Khddam.ma';
  static const String appTagline = 'Find trusted professionals near you.';
  static const String appTaglineFr = 'Trouvez des professionnels de confiance près de chez vous.';
  static const String appTaglineAr = 'ابحث عن مهنيين موثوقين بالقرب منك';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.khddam.ma/api/v1';
  static const String wsUrl = 'wss://api.khddam.ma/ws';
  static const int apiTimeout = 30000; // milliseconds
  static const int uploadTimeout = 60000;

  // Pagination
  static const int pageSize = 20;
  static const int searchPageSize = 15;

  // Maps
  static const double defaultLatitude = 33.5731; // Casablanca
  static const double defaultLongitude = -7.5898;
  static const double defaultZoom = 14.0;
  static const double searchRadiusKm = 25.0;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 64;
  static const int otpLength = 6;
  static const int maxBioLength = 500;
  static const int maxReviewLength = 1000;
  static const int maxProblemDescLength = 2000;
  static const int maxPhotos = 5;
  static const int maxPortfolioPhotos = 20;
  static const double maxFileSize = 10.0; // MB

  // Phone
  static const String moroccanCountryCode = '+212';
  static const String phonePattern = r'^(\+212|0)(6|7)\d{8}$';

  // Currency
  static const String currencyCode = 'MAD';
  static const String currencySymbol = 'DH';

  // Cache
  static const int cacheMaxAge = 300; // seconds (5 min)
  static const int imageCacheMaxAge = 86400; // seconds (24h)

  // Animation durations
  static const int animFast = 200;
  static const int animMedium = 350;
  static const int animSlow = 500;
  static const int splashDuration = 2500;

  // UI
  static const double cardRadius = 12.0;
  static const double buttonRadius = 8.0;
  static const double inputRadius = 8.0;
  static const double containerRadius = 16.0;
  static const double heroRadius = 24.0;
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 16.0;

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';
  static const String themeKey = 'app_theme';
  static const String onboardingKey = 'onboarding_complete';
  static const String fcmTokenKey = 'fcm_token';

  // Moroccan Cities
  static const List<String> moroccanCities = [
    'Casablanca',
    'Rabat',
    'Salé',
    'Marrakech',
    'Agadir',
    'Tangier',
    'Fès',
    'Meknès',
    'Oujda',
    'Kenitra',
    'El Jadida',
    'Mohammedia',
    'Beni Mellal',
    'Tétouan',
    'Safi',
    'Khouribga',
    'Taza',
    'Nador',
    'Settat',
    'Berrechid',
    'Khemisset',
    'Inezgane',
    'Ksar El Kebir',
    'Larache',
    'Guelmim',
    'Errachidia',
    'Ouarzazate',
  ];
}
