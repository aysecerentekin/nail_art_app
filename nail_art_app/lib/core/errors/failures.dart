// lib/core/errors/failures.dart

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure { //sunucu kaynaklı hata oluşursa çalışır.
  const ServerFailure({super.message = 'Sunucu hatası oluştu.'});
}

class CacheFailure extends Failure { //veri okunmadığında kullanılır.
  const CacheFailure({super.message = 'Yerel veri hatası oluştu.'});
}

class NetworkFailure extends Failure { //bağlantı hatası bulunursa çalışır.
  const NetworkFailure({super.message = 'İnternet bağlantısı yok.'});
}

class NotFoundFailure extends Failure { //tırnak tasarımı bulunamazsa çalışır.
  const NotFoundFailure({super.message = 'Tasarım bulunamadı.'});
}
