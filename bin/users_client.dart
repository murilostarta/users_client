import 'package:users_client/cli/cli.dart';

void main(List<String> arguments) async {
  var cli = UsersCLI();
  var loop = true;

  while (loop) {
    loop = await cli.menu();
  }
}
