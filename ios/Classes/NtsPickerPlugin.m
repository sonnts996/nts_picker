#import "NtsPickerPlugin.h"
#if __has_include(<nts_picker/nts_picker-Swift.h>)
#import <nts_picker/nts_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "nts_picker-Swift.h"
#endif

@implementation NtsPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNtsPickerPlugin registerWithRegistrar:registrar];
}
@end
