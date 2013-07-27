#import "NSUserDefaults+App.h"
#import "BDKConstants.h"

@implementation NSUserDefaults (App)

+ (BOOL)deviceIsiOS7 {
    return [[self standardUserDefaults] boolForKey:kBDKDefaultsDeviceIsiOS7];
}

+ (BOOL)deviceIs4Inch {
    return [[self standardUserDefaults] boolForKey:kBDKDefaultsDeviceIs4Inch];
}

+ (BOOL)deviceIsPad {
    return [[self standardUserDefaults] boolForKey:kBDKDefaultsDeviceIsPad];
}

@end
