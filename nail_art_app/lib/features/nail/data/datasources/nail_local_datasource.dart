// lib/features/nail/data/datasources/nail_local_datasource.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/app_constants.dart';
import '../models/nail_design_model.dart';

abstract class NailLocalDataSource {
  Future<List<NailDesignModel>> getCachedDesigns();
  Future<void> cacheDesigns(List<NailDesignModel> designs);
  Future<List<String>> getFavoriteIds();
  Future<void> saveFavoriteIds(List<String> ids);
}

class NailLocalDataSourceImpl implements NailLocalDataSource {
  final SharedPreferences sharedPreferences;

  NailLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<NailDesignModel>> getCachedDesigns() async {
    final jsonString = sharedPreferences.getString('cached_designs');
    if (jsonString != null) {
      final List decoded = json.decode(jsonString) as List;
      return decoded
          .map((e) => NailDesignModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw const CacheException(message: 'Cache\'de tasarım bulunamadı');
  }

  @override
  Future<void> cacheDesigns(List<NailDesignModel> designs) async {
    final jsonString = json.encode(designs.map((d) => d.toJson()).toList());
    await sharedPreferences.setString('cached_designs', jsonString);
  }

  @override
  Future<List<String>> getFavoriteIds() async {
    return sharedPreferences.getStringList(AppConstants.favoritesKey) ?? [];
  }

  @override
  Future<void> saveFavoriteIds(List<String> ids) async {
    await sharedPreferences.setStringList(AppConstants.favoritesKey, ids);
  }
}
