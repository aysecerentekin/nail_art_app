// lib/features/nail/data/models/nail_design_model.dart

import '../../domain/entities/nail_design.dart';

//entity
class NailDesignModel extends NailDesign {
  const NailDesignModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.category,
    required super.colors,
    required super.rating,
    required super.reviewCount,
    required super.difficulty,
    required super.durationMinutes,
    required super.isFavorite,
    required super.steps,
    required super.artistName,
  });
//map verisini modele dönüştürme.
  factory NailDesignModel.fromJson(Map<String, dynamic> json) {
    return NailDesignModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      colors: List<String>.from(json['colors'] as List),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      difficulty: json['difficulty'] as String,
      durationMinutes: json['durationMinutes'] as int,
      isFavorite: json['isFavorite'] as bool? ?? false,
      steps: List<String>.from(json['steps'] as List),
      artistName: json['artistName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'colors': colors,
      'rating': rating,
      'reviewCount': reviewCount,
      'difficulty': difficulty,
      'durationMinutes': durationMinutes,
      'isFavorite': isFavorite,
      'steps': steps,
      'artistName': artistName,
    };
  }

  
//favori durumunu güncelleyerek nesnenin yeni bir kopyasını oluşturur
  NailDesignModel copyWithFavorite(bool isFavorite) {
    return NailDesignModel(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      category: category,
      colors: colors,
      rating: rating,
      reviewCount: reviewCount,
      difficulty: difficulty,
      durationMinutes: durationMinutes,
      isFavorite: isFavorite,
      steps: steps,
      artistName: artistName,
    );
  }
}
