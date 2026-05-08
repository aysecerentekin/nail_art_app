// lib/features/nail/presentation/cubits/nail_detail_state.dart

part of 'nail_detail_cubit.dart';

abstract class NailDetailState extends Equatable {
  const NailDetailState();
  @override
  List<Object?> get props => [];
}

class NailDetailInitial extends NailDetailState {
  const NailDetailInitial();
}

class NailDetailLoaded extends NailDetailState {
  final NailDesign design;
  const NailDetailLoaded({required this.design});

  @override
  List<Object?> get props => [design];
}

class NailDetailError extends NailDetailState {
  final String message;
  const NailDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
