import 'package:test/test.dart' as t;
import 'package:leveldb/leveldb.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'utils.dart';

void main() {
  t.group('Iterator', () {
    LevelDB db;
    Options options = Options.byDefault(createIfMissing: true);
    String filePath;
    Map<String, String> entries;

    // create database
    t.setUpAll(() async {
      filePath = path.joinAll([
        (await getTemporaryDirectory()).path,
        'leveldb',
        'iterator.leveldb',
      ]);
      db = LevelDB.open(
        options: options.copyWith(),
        filePath: filePath,
      );
      entries = RandomMap.random(16, 32);
    });

    // put some data
    t.setUp(() {
      print(entries);
      db.putAllStrings(entries);
    });

    // clear database
    t.tearDown(() {
      db.deleteAllStringKeys(entries.keys.toList());
    });

    // close and delete database
    t.tearDownAll(() async {
      db.close();
      LevelDB.destroy(filePath, options);
      options.dispose();
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
