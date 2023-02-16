FROM dart:stable

WORKDIR /bot

# Install dependencies
COPY pubspec.* /bot/
RUN dart pub get

# Copy code
COPY . /bot/
RUN dart pub get --offline

# Compile bot into executable
RUN dart run nyxx_commands:compile --compile -o invite_brute_forcer.g.dart --no-compile bin/invite_brute_forcer.dart
RUN dart compile exe -o invite_brute_forcer invite_brute_forcer.g.dart

CMD [ "./invite_brute_forcer" ]
