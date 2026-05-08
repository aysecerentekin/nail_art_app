// lib/features/nail/presentation/cubits/favorites_state.dart

part of 'favorites_cubit.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<NailDesign> designs;
  const FavoritesLoaded({required this.designs});

  @override
  List<Object?> get props => [designs];
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError({required this.message});

  @override
  List<Object?> get props => [message];
}
