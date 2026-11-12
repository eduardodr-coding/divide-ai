import 'dart:io';

import 'package:flutter/services.dart';

/// Carrega Inter e MaterialIcons no ambiente de teste (por padrão o
/// flutter_test usa a fonte "Ahem", que deixa os textos bem mais largos).
Future<void> loadAppFonts() async {
  await _load('Inter', [
    for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold'])
      'assets/fonts/Inter-$w.ttf',
  ]);
  await _load('MaterialIcons', [
    '${_flutterRoot()}/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
  ]);
}

Future<void> _load(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final f in files) {
    final bytes = File(f).readAsBytesSync();
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
  }
  await loader.load();
}

String _flutterRoot() {
  final env = Platform.environment['FLUTTER_ROOT'];
  if (env != null) return env;
  // .../flutter/bin/cache/dart-sdk/bin/dart(.exe) -> .../flutter
  var dir = File(Platform.resolvedExecutable).parent;
  for (var i = 0; i < 4; i++) {
    dir = dir.parent;
  }
  return dir.path;
}
