// lib/features/nail/data/repositories/nail_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/nail_design.dart';
import '../../domain/repositories/nail_repository.dart';
import '../datasources/nail_local_datasource.dart';
import '../datasources/nail_remote_datasource.dart';
import '../models/nail_design_model.dart';

class NailRepositoryImpl implements NailRepository {
  final NailRemoteDataSource remoteDataSource; //tasarımları ve hafızadan favori ıdleri çeker.
  final NailLocalDataSource localDataSource;

  NailRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<NailDesign>>> getNailDesigns() async {
    try {
      final remoteDesigns = await remoteDataSource.getNailDesigns();
      final favoriteIds = await localDataSource.getFavoriteIds();

      final designsWithFavorites = remoteDesigns
          .map((d) => d.copyWithFavorite(favoriteIds.contains(d.id)))
          .toList();

      await localDataSource.cacheDesigns(designsWithFavorites);
      return Right(designsWithFavorites);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (_) {
      // Ağ yoksa cache'den dön
      try {
        final cached = await localDataSource.getCachedDesigns();
        return Right(cached);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<NailDesign>>> getNailDesignsByCategory(
      String category) async {
    final result = await getNailDesigns();
    return result.map(
      (designs) =>
          designs.where((d) => d.category == category).toList(),
    );
  }

  @override
  Future<Either<Failure, NailDesign>> getNailDesignById(String id) async {
    try {
      final design = await remoteDataSource.getNailDesignById(id);
      final favoriteIds = await localDataSource.getFavoriteIds();
      return Right(design.copyWithFavorite(favoriteIds.contains(design.id)));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(NotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(
      String id, bool isFavorite) async {
    try {
      final favoriteIds = await localDataSource.getFavoriteIds();
      List<String> updatedIds = List.from(favoriteIds);

      if (isFavorite) {
        if (!updatedIds.contains(id)) updatedIds.add(id);
      } else {
        updatedIds.remove(id);
      }

      await localDataSource.saveFavoriteIds(updatedIds); //güncel favori ıd listesini yerel hafızaya kaydeder
      return Right(isFavorite);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<NailDesign>>> getFavoriteDesigns() async {
    try {
      final favoriteIds = await localDataSource.getFavoriteIds(); //favori ıdleri ve tüm tasarımları birleştirir.
      final allDesigns = await remoteDataSource.getNailDesigns(); //favori ıd listesinde olan tasarımları filtreler ve değerlerini true yapar.
      

      final favorites = allDesigns
          .where((d) => favoriteIds.contains(d.id))
          .map((d) => d.copyWithFavorite(true))
          .toList();

      return Right(favorites);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
