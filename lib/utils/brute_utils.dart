import 'dart:async';

import 'package:nyxx/nyxx.dart';

class BruteUtils {
  static late DateTime lastGenerated;

  static Future<void> startBrute(
    IGuildChannel targetChannel,
    RegExp regex, {
    required ITextGuildChannel notifyChannel,
    bool loopForever = false,
  }) async {
    lastGenerated = DateTime.now();
    // Create the invite
    IInvite? invite =
        await targetChannel.createInvite(maxAge: 0, maxUses: 0, unique: true);
    // If it doesn't match, delete it and generate a new one
    while (loopForever || invite == null || !regex.hasMatch(invite.code)) {
      try {
        await Future.delayed(Duration(seconds: 3));
        if (invite != null) {
          await invite.delete();
        }
        invite = await targetChannel.createInvite(
            maxAge: 0, maxUses: 0, unique: true);
        print(invite.code);
        if (regex.hasMatch(invite.code)) {
          await notifyChannel.sendMessage(MessageBuilder.content(
              'Brute forced invite for <#${targetChannel.id}>: ${invite.url}'));
          // Without this "if", it would loop forever in regular cycles
          if (loopForever) {
            // Prevent deletion
            invite = null;
          }
        }
      } catch (e, st) {
        print(e);
        print(st);
        invite = null;
      }
    }
    await notifyChannel.sendMessage(MessageBuilder.content(
        'Done.'));
    return;
  }
}
