// lib/features/nail/domain/usecases/get_design_by_id.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/nail_design.dart';
import '../repositories/nail_repository.dart';

//tek bir tırnak tasarımı getirir
class GetDesignById implements UseCase<NailDesign, GetDesignByIdParams> {
  final NailRepository repository;
  GetDesignById(this.repository);

  @override
  Future<Either<Failure, NailDesign>> call(GetDesignByIdParams params) async {
    return repository.getNailDesignById(params.id);
  }
}

class GetDesignByIdParams extends Equatable {
  final String id;
  const GetDesignByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}
