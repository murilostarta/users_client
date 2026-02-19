import 'dart:developer' as developer;
import 'package:users_client/client/adapter/dio_adapter.dart';

class BaseClient {
  late bool https;

  late String host;

  late String port;

  late String wsEndpoint;

  late String api;

  late String wsURL;

  late DioAdapter dio;

  BaseClient([this.https = false, this.host = 'localhost', this.port = '8080']) {
    wsEndpoint = 'users';
    api = 'api';
    changeServiceConnection(https, host, port);
    developer.log('DioAdapter selected: $dioAdapterPlatform', name: 'dio_adapter');
    dio = DioAdapter(BaseOptions(
      connectTimeout: Duration(seconds: 5),
      sendTimeout: Duration(seconds: 5),
    ));
  }

  void changeServiceConnection(bool https, String host, String port) {
    this.host = host;
    this.port = port;
    _handleHTTP(https);
    _createURL();
  }

  void _handleHTTP(bool https) {
    if (https) {
      wsURL = 'https://';
    } else {
      wsURL = 'http://';
    }
  }

  void _createURL() {
    var urlBase = host + ':' + port;
    wsURL = wsURL + urlBase + '/' + api + '/' + wsEndpoint + '/';
  }

  Future<Response> get(
    String path, {
    Map<String, Object?>? headers,
  }) {
    return dio.get(path,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> put(String path, {Map<String, Object?>? headers, Object? body}) {
    return dio.put(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> post(String path, {Map<String, Object?>? headers, Object? body}) {
    return dio.post(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> delete(String path, {Map<String, Object?>? headers, Object? body}) {
    return dio.delete(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }
}
