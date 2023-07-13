
#ifdef RCT_NEW_ARCH_ENABLED
#import "RNAccessibilitySettingsSpec.h"

@interface AccessibilitySettings : NSObject <NativeAccessibilitySettingsSpec>
#else
#import <React/RCTBridgeModule.h>

@interface AccessibilitySettings : NSObject <RCTBridgeModule>
#endif

@end
