// lib/features/nail/domain/repositories/nail_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/nail_design.dart';

abstract class NailRepository {
  /// Tüm tasarımları getirir
  Future<Either<Failure, List<NailDesign>>> getNailDesigns();

  /// Kategoriye göre filtreler
  Future<Either<Failure, List<NailDesign>>> getNailDesignsByCategory(
      String category);

  /// ID'ye göre tekil tasarım getirir
  Future<Either<Failure, NailDesign>> getNailDesignById(String id);

  /// Favori ekle / kaldır
  Future<Either<Failure, bool>> toggleFavorite(String id, bool isFavorite);

  /// Favori tasarımları getirir
  Future<Either<Failure, List<NailDesign>>> getFavoriteDesigns();
}
