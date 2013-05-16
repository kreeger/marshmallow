#import "IFBKUser.h"
#import "IFBKCFUser.h"

@implementation IFBKUser

@dynamic userType;

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model {
    IFBKCFUser *user = (IFBKCFUser *)model;
    NSArray *attributes = @[@"identifier", @"name", @"emailAddress", @"admin", @"createdAt", @"type", @"avatarUrl", @"apiAuthToken"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[user valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

- (IFBKUserType)userType {
    NSNumber *type = [[self class] userTypeMappings][self.type];
    return type ? [type integerValue] : IFBKUserTypeUnknown;
}

- (BOOL)isCurrentUser {
    return self.launchpadAccount != nil;
}

- (NSURL *)avatarUrlValue {
    return [NSURL URLWithString:self.avatarUrl];
}

+ (NSDictionary *)userTypeMappings {
    return @{@"Member": @(IFBKUserTypeMember),
             @"Guest": @(IFBKUserTypeGuest),};
}


@end
