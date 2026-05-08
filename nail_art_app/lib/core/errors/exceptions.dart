// lib/core/errors/exceptions.dart

class ServerException implements Exception {
  final String message;
  const ServerException({this.message = 'Sunucu hatası'});
}

class CacheException implements Exception {
  final String message;
  const CacheException({this.message = 'Cache hatası'});
}

class NetworkException implements Exception {
  final String message;
  const NetworkException({this.message = 'Ağ hatası'});
}
