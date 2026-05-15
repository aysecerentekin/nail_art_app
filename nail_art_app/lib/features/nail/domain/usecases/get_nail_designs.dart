// lib/features/nail/domain/usecases/get_nail_designs.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nail_design.dart';
import '../repositories/nail_repository.dart';

class GetNailDesigns implements UseCase<List<NailDesign>, GetNailDesignsParams> {
  final NailRepository repository;
  GetNailDesigns(this.repository);

  @override
  Future<Either<Failure, List<NailDesign>>> call(
      GetNailDesignsParams params) async {
    if (params.category == null || params.category == 'Tümü') { //kategori seçilmemişse veya tümü seçilmişse tüm listeyi getirir.
      return repository.getNailDesigns();
    }
    return repository.getNailDesignsByCategory(params.category!); // belirli bir kategori seçildeyse o kategoriye göre filtreleme yapılır.
  }
}

class GetNailDesignsParams extends Equatable {
  final String? category; //filtrelenecek kategori adı
  const GetNailDesignsParams({this.category});

  @override
  List<Object?> get props => [category];
}
