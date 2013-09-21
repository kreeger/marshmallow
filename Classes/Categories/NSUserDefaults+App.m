#import "NSUserDefaults+App.h"
#import "BDKConstants.h"

@implementation NSUserDefaults (App)

+ (BOOL)deviceIs4Inch {
    return [[self standardUserDefaults] boolForKey:BDKDefaultsDeviceIs4Inch];
}

+ (BOOL)deviceIsPad {
    return [[self standardUserDefaults] boolForKey:BDKDefaultsDeviceIsPad];
}

@end
