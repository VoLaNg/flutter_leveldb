import 'package:flutter_driver/driver_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'utils.dart' show PathProvider;
// ignore: avoid_relative_lib_imports
import '../lib/main.dart' as app;

void main() {
  enableFlutterDriverExtension(handler: handler);

  app.main();
}

Future<String> handler(String command) {
  switch (command) {
    case PathProvider.tempDirCommand:
      return getTempDir();
    default:
      return null;
  }
}

Future<String> getTempDir() async {
  return path.joinAll([
    (await getTemporaryDirectory()).path,
    'leveldb_test',
    'test.leveldb',
  ]);
}
