#import "IFBKUser.h"
#import "IFBKLaunchpadAccount.h"

#import <IFBKThirtySeven/IFBKCFUser.h>

@implementation IFBKUser

@dynamic admin;
@dynamic apiAuthToken;
@dynamic avatarUrl;
@dynamic createdAt;
@dynamic emailAddress;
@dynamic identifier;
@dynamic name;
@dynamic type;
@dynamic launchpadAccount;

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model {
    IFBKCFUser *user = (IFBKCFUser *)model;
    NSArray *attributes = @[@"identifier", @"name", @"emailAddress", @"admin", @"createdAt", @"type", @"avatarUrl",
                            @"apiAuthToken"];
    [attributes enumerateObjectsUsingBlock:^(NSString *attribute, NSUInteger idx, BOOL *stop) {
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
