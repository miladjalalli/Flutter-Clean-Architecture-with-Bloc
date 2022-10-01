import "dart:async";
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';

part "rest_client_service.chopper.dart";

@ChopperApi(baseUrl: API_BASE_URL)
abstract class RestClientService extends ChopperService {
  static RestClientService create([ChopperClient client]) =>
      _$RestClientService(client);

  @Get(path: NEWS, headers: {'Content-type': 'application/json'})
  Future<Response> getNews(@Body() Map<String, dynamic> parameters);
}
