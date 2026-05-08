// lib/features/nail/domain/usecases/toggle_favorite.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/nail_repository.dart';

class ToggleFavorite implements UseCase<bool, ToggleFavoriteParams> {
  final NailRepository repository;
  ToggleFavorite(this.repository);

  @override
  Future<Either<Failure, bool>> call(ToggleFavoriteParams params) async {
    return repository.toggleFavorite(params.id, params.isFavorite);
  }
}

class ToggleFavoriteParams extends Equatable {
  final String id;
  final bool isFavorite;
  const ToggleFavoriteParams({required this.id, required this.isFavorite});

  @override
  List<Object?> get props => [id, isFavorite];
}
