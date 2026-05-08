// lib/core/utils/app_constants.dart

class AppConstants {
  AppConstants._();

  static const String appName = 'Nail Art';
  static const String favoritesKey = 'favorite_nail_designs';

  // Kategoriler
  static const List<String> categories = [
    'Tümü',
    'Klasik',
    'Ombre',
    'Nail Art',
    'French',
    'Jel',
    'Akrilik',
    'Glitter',
    'Floral',
    'Geometrik',
    'Pastel',
  ];

  // Mock resim URL'leri (gerçek uygulamada API'den gelir)
  static const String baseImageUrl = 'https://picsum.photos';
}
