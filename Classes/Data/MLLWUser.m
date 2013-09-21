#import "MLLWUser.h"
#import "MLLWLaunchpadAccount.h"

#import <IFBKThirtySeven/IFBKCFUser.h>

@implementation MLLWUser

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

- (MLLWUserType)userType {
    NSNumber *type = [[self class] userTypeMappings][self.type];
    return type ? [type integerValue] : MLLWUserTypeUnknown;
}

- (BOOL)isCurrentUser {
    return self.launchpadAccount != nil;
}

- (NSURL *)avatarUrlValue {
    return [NSURL URLWithString:self.avatarUrl];
}

+ (NSDictionary *)userTypeMappings {
    return @{@"Member": @(MLLWUserTypeMember),
             @"Guest": @(MLLWUserTypeGuest),};
}

@end
