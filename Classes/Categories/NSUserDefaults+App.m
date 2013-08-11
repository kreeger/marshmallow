#import "NSUserDefaults+App.h"
#import "BDKConstants.h"

@implementation NSUserDefaults (App)

+ (BOOL)deviceIs4Inch {
    return [[self standardUserDefaults] boolForKey:kBDKDefaultsDeviceIs4Inch];
}

+ (BOOL)deviceIsPad {
    return [[self standardUserDefaults] boolForKey:kBDKDefaultsDeviceIsPad];
}

@end
