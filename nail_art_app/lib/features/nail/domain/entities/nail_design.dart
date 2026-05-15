// lib/features/nail/domain/entities/nail_design.dart

import 'package:equatable/equatable.dart';

//tırnak tasarımlarını temsil eden sınıf.
class NailDesign extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> colors;
  final double rating;
  final int reviewCount;
  final String difficulty; 
  final int durationMinutes;
  final bool isFavorite;
  final List<String> steps;
  final String artistName;

  //veri güvenliği ve değişmezlik
  const NailDesign({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.colors,
    required this.rating,
    required this.reviewCount,
    required this.difficulty,
    required this.durationMinutes,
    required this.isFavorite,
    required this.steps,
    required this.artistName,
  });

  //favoriye ekleme/çıkarma durumlarında arayüzü tetiklemek kullanılır.
  NailDesign copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    List<String>? colors,
    double? rating,
    int? reviewCount,
    String? difficulty,
    int? durationMinutes,
    bool? isFavorite,
    List<String>? steps,
    String? artistName,
  }) {
    return NailDesign(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      colors: colors ?? this.colors,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      difficulty: difficulty ?? this.difficulty,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      isFavorite: isFavorite ?? this.isFavorite,
      steps: steps ?? this.steps,
      artistName: artistName ?? this.artistName,
    );
  }

  @override
  List<Object?> get props => [
        id, title, description, imageUrl, category,
        colors, rating, reviewCount, difficulty,
        durationMinutes, isFavorite, steps, artistName,
      ];
}
