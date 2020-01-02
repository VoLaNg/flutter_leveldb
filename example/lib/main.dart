import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:leveldb/interop/interop.dart';

void main() {
  runApp(Container());

  final lib = LibLevelDB.lookupLib(DynamicLibrary.open('libleveldb.so'));
  print(lib.runtimeType);
}
