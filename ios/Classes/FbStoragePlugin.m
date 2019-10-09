#import "FbStoragePlugin.h"
#import <fb_storage/fb_storage-Swift.h>

@implementation FbStoragePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFbStoragePlugin registerWithRegistrar:registrar];
}
@end
