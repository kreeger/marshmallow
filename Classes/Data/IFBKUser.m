#import "IFBKUser.h"
#import "BDKCFUser.h"

@implementation IFBKUser

@dynamic userType;

- (void)updateWithBDKCFModel:(BDKCFModel *)model
{
    BDKCFUser *user = (BDKCFUser *)model;
    NSArray *attributes = @[@"identifier", @"name", @"emailAddress", @"admin", @"createdAt", @"type", @"avatarUrl"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[user valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

+ (NSDictionary *)userTypeMappings
{
    return @{@"Member": @(IFBKUserTypeMember),
             @"Guest": @(IFBKUserTypeGuest),};
}

- (IFBKUserType)userType
{
    NSNumber *type = [[self class] userTypeMappings][self.type];
    return type ? [type integerValue] : IFBKUserTypeUnknown;
}

- (NSURL *)avatarUrlValue {
    return [NSURL URLWithString:self.avatarUrl];
}

@end
