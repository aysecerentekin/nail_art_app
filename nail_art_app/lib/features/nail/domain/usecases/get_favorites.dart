// lib/features/nail/domain/usecases/get_favorites.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nail_design.dart';
import '../repositories/nail_repository.dart';

class GetFavorites implements UseCase<List<NailDesign>, NoParams> {
  final NailRepository repository;
  GetFavorites(this.repository);

  @override
  Future<Either<Failure, List<NailDesign>>> call(NoParams params) async {
    return repository.getFavoriteDesigns();
  }
}
