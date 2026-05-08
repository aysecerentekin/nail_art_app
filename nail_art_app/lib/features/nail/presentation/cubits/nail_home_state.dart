// lib/features/nail/presentation/cubits/nail_home_state.dart

part of 'nail_home_cubit.dart';

abstract class NailHomeState extends Equatable {
  const NailHomeState();
  @override
  List<Object?> get props => [];
}

class NailHomeInitial extends NailHomeState {
  const NailHomeInitial();
}

class NailHomeLoading extends NailHomeState {
  const NailHomeLoading();
}

class NailHomeLoaded extends NailHomeState {
  final List<NailDesign> designs;
  final String selectedCategory;

  const NailHomeLoaded({
    required this.designs,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [designs, selectedCategory];
}

class NailHomeError extends NailHomeState {
  final String message;
  const NailHomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
