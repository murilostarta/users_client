import 'dart:developer' as developer;
import 'package:users_client/client/adapter/dio_adapter.dart';

class BaseClient {
  static String Function()? routeNameProvider;
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
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        developer.log(
          'REQ ${options.method} ${options.uri}',
          name: 'api',
        );
        handler.next(options);
      },
      onResponse: (response, handler) {
        developer.log(
          'RES ${response.statusCode} ${response.requestOptions.uri}',
          name: 'api',
        );
        handler.next(response);
      },
      onError: (e, handler) {
        developer.log(
          'Dio error: ${e.message}',
          name: 'dio',
          error: e,
          stackTrace: e.stackTrace,
        );
        handler.next(e);
      },
    ));
  }

  void changeServiceConnection(bool https, String host, String port) {
    this.https = https;
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
    var urlBase = host;
    if (!(https && port == '443') && !(!https && port == '80') && port.isNotEmpty) {
      urlBase = host + ':' + port;
    }
    wsURL = wsURL + urlBase + '/' + api + '/' + wsEndpoint + '/';
  }

  Future<Response> get(
    String path, {
    Map<String, Object?>? headers,
  }) {
    final route = routeNameProvider?.call() ?? 'unknown';
    developer.log('GET $path route=$route', name: 'api');
    return dio.get(path,
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> put(String path, {Map<String, Object?>? headers, Object? body}) {
    final route = routeNameProvider?.call() ?? 'unknown';
    developer.log('PUT $path route=$route', name: 'api');
    return dio.put(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> post(String path, {Map<String, Object?>? headers, Object? body}) {
    final route = routeNameProvider?.call() ?? 'unknown';
    developer.log('POST $path route=$route', name: 'api');
    return dio.post(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }

  Future<Response> delete(String path, {Map<String, Object?>? headers, Object? body}) {
    final route = routeNameProvider?.call() ?? 'unknown';
    developer.log('DELETE $path route=$route', name: 'api');
    return dio.delete(path,
        data: body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
          responseType: ResponseType.plain,
        ));
  }
}
