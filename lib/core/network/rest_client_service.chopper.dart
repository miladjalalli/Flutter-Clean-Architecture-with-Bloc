// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$RestClientService extends RestClientService {
  _$RestClientService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = RestClientService;

  Future<Response> getNews(Map<String, dynamic> parameters) {
    final $url = '$API_BASE_URL/$NEWS';
    final $headers = {'Content-type': 'application/json'};
    final $request =
        Request('GET', $url, client.baseUrl, parameters: parameters, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

}
