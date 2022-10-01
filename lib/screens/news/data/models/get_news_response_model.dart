import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/domain/entities/get_news_response.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GetNewsResponseModel extends GetNewsResponseDto {
  GetNewsResponseModel() : super();

  GetNewsResponseModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['data'] != null) {
      data = <News>[];
      json['data'].forEach((v) {
        data.add(new News.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}
