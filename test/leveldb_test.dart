import 'dart:io';
import 'package:leveldb/interop/interop.dart';
import 'package:test/test.dart';
import 'utils.dart';

void main() {
  // setUpAll(() async {
  //   final dir = Directory(TestDyLib.workingDirectory);
  //   await dir.create(recursive: true);
  //   expect(await dir.exists(), true);

  //   final cmake = await Process.run(
  //       'cmake',
  //       [
  //         '-E',
  //         'env',
  //         'CXXFLAGS="-std=c++11"',
  //         'cmake',
  //         TestDyLib.cmakePath,
  //         '-DBUILD_SHARED_LIBS=1',
  //         '-DCMAKE_BUILD_TYPE=MinSizeRel',
  //         '-DLEVELDB_BUILD_TESTS=0',
  //         '-DLEVELDB_BUILD_BENCHMARKS=0',
  //         if (Platform.isMacOS) '-DCMAKE_MACOSX_RPATH=1',
  //       ],
  //       workingDirectory: TestDyLib.workingDirectory);
  //   expect(cmake.exitCode, 0, reason: 'cmake exit with code ${cmake.exitCode}');

  //   print(cmake.stdout);

  //   final make = await Process.run('make', [],
  //       workingDirectory: TestDyLib.workingDirectory);
  //   expect(make.exitCode, 0, reason: 'make exit with code ${make.exitCode}');

  //   final file = File(
  //     './${TestDyLib.workingDirectory}/lib${TestDyLib.libName}.dylib',
  //   );
  //   expect(await file.exists(), true);
  // });

  // tearDownAll(() async {
  //   final dir = Directory('./${TestDyLib.workingDirectory}');
  //   expect(dir.exists(), true);

  //   await dir.delete(recursive: true);
  //   expect(dir.exists(), false);
  // });

  test('LibLevelDB.lookupLib', () {
    final lib = LibLevelDB.lookupLib(TestDyLib.test_load());
    expect(lib, isNotNull);
  });
}
