import 'package:dio/dio.dart';

abstract class UserUCInterface {
  Future<Response> createUser(String name, String email, String password);

  Future<Response> authenticate(String email, String password);

  Future<Response> createAuthenticate(String name, String email, String password);

  Future<Response> recoverPassword(String email);

  Future<Response> updateEmail(String email, String newEmail, String jwt);

  Future<Response> updatePassword(String email, String password, String newPassword, String jwt);

  Future<Response> deleteUser(String email, String jwt);

  void changeServiceConnection(bool https, String host, String port);
}
