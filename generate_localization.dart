import 'dart:io';

void main() {
  final process = Process.run(
    'flutter',
    [
      'pub',
      'run',
      'easy_localization:generate',
      '-S',
      'assets/i18n',
      '-O',
      'lib/gen',
      '-o',
      'locale_keys.g.dart',
      '-f',
      'keys',
    ],
  );

  process.then((result) {
    if (result.exitCode == 0) {
      print('ヘ(◕。◕ヘ) Localization files generated successfully.');
    } else {
      print('Error generating localization files: ${result.stderr}');
    }
  });
}
