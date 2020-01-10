
import 'package:flutter_test/flutter_test.dart' as t;
import 'package:leveldb/leveldb.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

void main() {
  LevelDB db;
  Options options = Options.byDefault(createIfMissing: true);
  String filePath;
  
  t.setUpAll(() async {
    filePath = path.joinAll([(await getTemporaryDirectory()).path, '/leveldb_test', '/iterator_test.leveldb']);
    db = LevelDB.open(options: options.copyWith(), filePath: filePath,);
  });

  t.tearDownAll(() async {
    db.close();
    LevelDB.destroy(filePath, options);
    options.dispose();
  });

  t.test('Iterate all objects' () {
    final iterator = db.iterator();

    // TODO: t.prints();
    while(iterator.moveNext()) {
      t.print(iterator.current);
    }
  });
}
