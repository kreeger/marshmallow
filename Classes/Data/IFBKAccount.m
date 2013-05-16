#import "IFBKAccount.h"
#import "IFBKCFAccount.h"
#import "IFBKLaunchpadAccount.h"

@implementation IFBKAccount

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model {
    IFBKCFAccount *account = (IFBKCFAccount *)model;
    NSArray *attributes = @[@"identifier", @"name", @"subdomain", @"plan", @"ownerIdentifier", @"storage",
                            @"createdAt", @"updatedAt"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[account valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

- (NSURL *)apiUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://%@.campfirenow.com", self.subdomain]];
}

- (IFBKUser *)user {
    return self.launchpadAccount.user;
}

@end
