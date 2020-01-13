import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart' as t;
import 'package:leveldb/leveldb.dart';
import 'utils.dart';

void main() {
  t.group('Iterator', () {
    FlutterDriver driver;
    LevelDB db;
    Options options = Options.byDefault(createIfMissing: true);
    String filePath;
    Map<String, String> entries;

    t.setUpAll(() async {
      driver = await FlutterDriver.connect();
      filePath = await driver.getTempDir();
      print('filePath is: $filePath');
      db = LevelDB.open(
        options: options.copyWith(),
        filePath: filePath,
      );
      entries = RandomMap.random(16, 32);
    });

    t.setUp(() {
      print(entries);
      db.putAllStrings(entries);
    });

    t.tearDown(() {
      db.deleteAllStringKeys(entries.keys.toList());
    });

    t.tearDownAll(() async {
      db.close();
      LevelDB.destroy(filePath, options);
      options.dispose();
      await driver?.close();
    });

    t.test('iterate and print all objects', () async {
      final iterator = db.iterator();

      Iterable<KeyValue<String, String>> databaseGenerator() sync* {
        while (iterator.moveNext()) {
          final kv = iterator.current;
          final key = String.fromCharCodes(kv.key.bytes);
          final value = String.fromCharCodes(kv.value.bytes);
          kv.dispose();
          yield KeyValue(key, value);
        }
      }

      final allEntries = Map.fromEntries(
        databaseGenerator().map((kv) => MapEntry(kv.key, kv.value)),
      );

      t.expect(allEntries, t.equals(entries));
    });
  });
}
