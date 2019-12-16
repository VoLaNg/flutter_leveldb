#import "LeveldbPlugin.h"
#if __has_include(<leveldb/leveldb-Swift.h>)
#import <leveldb/leveldb-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "leveldb-Swift.h"
#endif

@implementation LeveldbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLeveldbPlugin registerWithRegistrar:registrar];
}
@end
