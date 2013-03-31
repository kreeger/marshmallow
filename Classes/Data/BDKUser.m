#import "BDKUser.h"
#import "BDKCFUser.h"

@implementation BDKUser

@dynamic userType;

#pragma mark - Properties

+ (NSDictionary *)userTypeMappings
{
    return @{@"Member": @(BDKUserTypeMember),
             @"Guest": @(BDKUserTypeGuest),};
}

- (BDKUserType)userType
{
    NSNumber *type = [[self class] userTypeMappings][self.type];
    return type ? type.integerValue : BDKUserTypeUnknown;
}

@end
