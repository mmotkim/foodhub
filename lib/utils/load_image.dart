import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:foodhub/gen/assets.gen.dart';

Future<void> loadImage(ImageProvider provider) {
  final ImageConfiguration config = ImageConfiguration(
    bundle: rootBundle,
    // devicePixelRatio: window.devicePixelRatio,
    platform: defaultTargetPlatform,
  );
  final Completer<void> completer = Completer<void>();
  final ImageStream stream = provider.resolve(config);

  late final ImageStreamListener listener;

  listener = ImageStreamListener((ImageInfo image, bool sync) {
    debugPrint('Image ${image.debugLabel} finished loading');
    completer.complete();
    stream.removeListener(listener);
  }, onError: (Object exception, StackTrace? stackTrace) {
    completer.complete();
    stream.removeListener(listener);
    FlutterError.reportError(FlutterErrorDetails(
      context: ErrorDescription('image failed to load'),
      library: 'image resource service',
      exception: exception,
      stack: stackTrace,
      silent: true,
    ));
  });

  stream.addListener(listener);
  return completer.future;
}

Future<void> loadInitialImages() async {
  await loadImage(Assets.images.welcomeBG.provider());
}
