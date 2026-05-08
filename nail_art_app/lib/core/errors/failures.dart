// lib/core/errors/failures.dart

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Sunucu hatası oluştu.'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Yerel veri hatası oluştu.'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'İnternet bağlantısı yok.'});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Tasarım bulunamadı.'});
}
