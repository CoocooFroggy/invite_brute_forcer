import 'dart:io';

import 'package:invite_brute_forcer/commands/brute_force.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  final client = NyxxFactory.createNyxxWebsocket(
    Platform.environment['TOKEN']!,
    GatewayIntents.guilds,
  );

  final commands = CommandsPlugin(
      prefix: (_) => '!',
      options: CommandsOptions(defaultCommandType: CommandType.slashOnly));

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commands);

  // Register commands, listeners, services and setup any extra packages here
  commands.addCommand(bruteForce);

  await client.connect();
}
