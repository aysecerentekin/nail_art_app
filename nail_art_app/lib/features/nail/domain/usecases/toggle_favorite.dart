// lib/features/nail/domain/usecases/toggle_favorite.dart
//favori durumunu değiştirmek.

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/nail_repository.dart';

//ürünü favoriye ekleme ve çıkarma işlemin yönetir.
class ToggleFavorite implements UseCase<bool, ToggleFavoriteParams> {
  final NailRepository repository;
  ToggleFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(ToggleFavoriteParams params) async {
    return repository.toggleFavorite(params.id, params.isFavorite); //favori durumunu repository üzerinden güncelleme.
  }
}

class ToggleFavoriteParams extends Equatable {
  final String id;
  final bool isFavorite; //yeni favori durumu
  const ToggleFavoriteParams({required this.id, required this.isFavorite});

  @override
  List<Object?> get props => [id, isFavorite];
}
