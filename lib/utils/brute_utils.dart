import 'dart:async';

import 'package:nyxx/nyxx.dart';

class BruteUtils {
  static Future<void> startBrute(
    IGuildChannel targetChannel,
    RegExp regex, {
    required ITextGuildChannel notifyChannel,
  }) async {
    // Create the invite
    IInvite invite =
        await targetChannel.createInvite(maxAge: 0, maxUses: 0, unique: true);
    // If it doesn't match, delete it and generate a new one
    while (!regex.hasMatch(invite.code)) {
      try {
        await invite.delete();
        invite = await targetChannel.createInvite(maxAge: 0, maxUses: 0, unique: true);
        print(invite.code);
        await Future.delayed(Duration(seconds: 3));
      } catch (e, st) {
        print(e);
        print(st);
        notifyChannel.sendMessage(
            MessageBuilder.content('Stuttered: $e\n'
                '```\n'
                '$st'
                '```'));
      }
    }
    await notifyChannel.sendMessage(
        MessageBuilder.content('Finished brute forcing invite for <#${targetChannel.id}>: ${invite.url}'));
    return;
  }
}
