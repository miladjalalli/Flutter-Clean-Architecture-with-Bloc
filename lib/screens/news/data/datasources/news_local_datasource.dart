import 'dart:convert';

import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/data/models/get_news_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NewsLocalDataSource {
  Future<GetNewsResponseDto> getLastNews();
  Future<void> cacheNews(GetNewsResponseDto newsModel);
}

class NewsLocalDataSourceImpl extends NewsLocalDataSource {
  final SharedPreferences sharedPreferences;

  NewsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheNews(GetNewsResponseDto loginModel) {
    return sharedPreferences.setString(CACHED_NEWS, jsonEncode(loginModel));
  }

  @override
  Future<GetNewsResponseDto> getLastNews() {
    String jsonStr = sharedPreferences.getString(CACHED_NEWS);
    if (jsonStr == null) {
      throw CacheException();
    }
    return Future.value(GetNewsResponseDto.fromJson(jsonDecode(jsonStr)));
  }
}
