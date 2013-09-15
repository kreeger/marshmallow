#import "NSObject+Marshmallow.h"

@implementation NSObject (Marshmallow)

- (BOOL)isNull {
    return [(NSNull *)self isEqual:[NSNull null]];
}

- (BOOL)isNotNull {
    return ![self isNull];
}

@end