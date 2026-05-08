// lib/features/nail/presentation/cubits/nail_detail_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/nail_design.dart';
import '../../domain/usecases/toggle_favorite.dart';

part 'nail_detail_state.dart';

class NailDetailCubit extends Cubit<NailDetailState> {
  final ToggleFavorite toggleFavorite;

  NailDetailCubit({required this.toggleFavorite})
      : super(const NailDetailInitial());

  void loadDesign(NailDesign design) {
    emit(NailDetailLoaded(design: design));
  }

  Future<void> onToggleFavorite() async {
    final currentState = state;
    if (currentState is! NailDetailLoaded) return;

    final design = currentState.design;
    final newValue = !design.isFavorite;

    final result = await toggleFavorite(
      ToggleFavoriteParams(id: design.id, isFavorite: newValue),
    );

    result.fold(
      (failure) => emit(NailDetailError(message: failure.message)),
      (_) => emit(NailDetailLoaded(
        design: design.copyWith(isFavorite: newValue),
      )),
    );
  }
}
