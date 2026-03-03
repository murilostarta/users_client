import 'dart:io';
import 'package:dio/dio.dart';
import 'package:users_client/client/base_client.dart';

class OrionUsers extends BaseClient {
  Future<Response> createUser(String name, String email, String password) {
    var url = wsURL + 'create';
    return post(url, body: {'name': name, 'email': email, 'password': password});
  }

  Future<Response> createAuthenticate(String name, String email, String password) {
    var url = wsURL + 'createAuthenticate';
    return post(url, body: {'name': name, 'email': email, 'password': password});
  }
  //Prod

  Future<Response> authenticate(String email, String password) {
    var url = wsURL + 'authenticate';
    return post(url, body: {'email': email, 'password': password});
  }

  Future<Response> forgotUser(String email) {
    var url = wsURL + 'forgot';
    return post(url, body: {'email': email});
  }

  Future<Response> retrieveUser(String hash, String password) {
    var url = wsURL + 'retrieve';
    return post(url, body: {'hash': hash, 'password': password});
  }

  Future<Response> updateUser(String id, String name, String email, String password, String jwt) {
    var url = wsURL + 'update';
    return post(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'id': id, 'name': name, 'email': email, 'password': password});
  }

  Future<Response> updateEmail(String email, String newEmail, jwt) {
    var url = wsURL + 'update/email';
    return put(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt}, body: {'email': email, 'newEmail': newEmail});
  }

  Future<Response> deleteUser(String email, String jwt) {
    var url = wsURL + 'delete';
    return delete(url, headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt}, body: {'email': email});
  }

  Future<Response> listUser(String id, String jwt) {
    var url = wsURL + 'list' + '/' + id;
    print(url);
    return get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt});
  }

  Future<Response> updatePassword(String email, String password, String newPassword, String jwt) {
    var url = wsURL + 'update' + '/' + 'password';

    return put(url,
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + jwt},
        body: {'email': email, 'password': password, 'newPassword': newPassword});
  }

  Future<Response> recoverPassword(String email) {
    var url = wsURL + 'recoverPassword';
    return post(url, body: {
      'email': email,
    });
  }
}
