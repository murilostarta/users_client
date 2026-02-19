import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:users_client/client/user_ws.dart';
import 'package:users_client/uc/user_uc_interface.dart';
import 'package:users_client/uc/user_uc.dart';

import 'orion_users_cli_test.mocks.dart';

@GenerateMocks([OrionUsers])
void main() {
  test('Create an user with small password', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.createUser('Orion', 'orion@test.com', '1234567'), throwsException);
  });

  test('Create user with a blank name', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.createUser('', 'orion@test.com', '12345678'), throwsException);
  });

  test('Create user with a blank e-mail', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.createUser('Orion', '', '12345678'), throwsException);
  });

  test('Create user with a blank password', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.createUser('Orion', 'orion@test.com', ''), throwsException);
  });

  test('Create user with an e-mail invalid', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.createUser('Orion', 'orion#test.com', '12345678'), throwsException);
  });

  test('Autenticantes a user with a blank e-mail', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.authenticate('', '12345678'), throwsException);
  });

  test('Autenticantes a user with a blank password', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.authenticate('orion@test.com', ''), throwsException);
  });

  test('Recovery password with a blank e-mail', () {
    UserUCInterface uc = UsersClient();
    expect(() => uc.recoverPassword(''), throwsException);
  });

  test('Create and authenticates a user', () {
    var ws = MockOrionUsers();
    when(ws.createUser('Orion', 'orion@test.com', '12345678')).thenAnswer((_) => Future<Response>.value(
        Response(requestOptions: RequestOptions(path: ''), data: '', headers: Headers(), statusCode: 200)));

    UserUCInterface uc = UsersClient();
    var response = uc.createAuthenticate('Orion', 'orion@test.com', '12345678');
    response.then((value) => {expect(200, value.statusCode)});
  });
}
