import 'package:invite_brute_forcer/utils/brute_utils.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

/// Brute forces an invite with the specified characters as a prefix.
///
/// [prefix] should be a String of characters that you want the invite URL to
/// start with.
///
/// - Generated links can have characters: 0-9 A-Z a-z
/// - 30 min links are 7 characters
/// - Permanent links are 10 characters
final bruteForce = ChatCommand(
  'brute-force',
  'Brute force an invite',
  checks: [GuildCheck.all()],
  id('brute-force',
      (IChatContext context, IGuildChannel targetChannel, String regex) async {
    final sourceChannel = context.channel as ITextGuildChannel;

    if (targetChannel is! ITextGuildChannel &&
        targetChannel is! IVoiceGuildChannel) {
      await context.respond(MessageBuilder.content(
          'Sorry, `channel` must be a text or voice channel.'));
      return;
    }

    await context.respond(MessageBuilder.content('Starting...'));

    // Run the brute forcer
    BruteUtils.startBrute(targetChannel, RegExp(regex),
        notifyChannel: sourceChannel);
  }),
);
