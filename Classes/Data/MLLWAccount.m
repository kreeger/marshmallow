#import "MLLWAccount.h"
#import "MLLWLaunchpadAccount.h"

#import <IFBKThirtySeven/IFBKCFAccount.h>

@implementation MLLWAccount

@dynamic createdAt;
@dynamic identifier;
@dynamic name;
@dynamic ownerIdentifier;
@dynamic plan;
@dynamic storage;
@dynamic subdomain;
@dynamic timeZone;
@dynamic updatedAt;
@dynamic launchpadAccount;

- (void)updateWithIFBKCFModel:(IFBKCFModel *)model {
    IFBKCFAccount *account = (IFBKCFAccount *)model;
    NSArray *attributes = @[@"identifier", @"name", @"subdomain", @"plan", @"ownerIdentifier", @"storage",
                            @"createdAt", @"updatedAt"];
    [attributes enumerateObjectsUsingBlock:^(NSString *attribute, NSUInteger idx, BOOL *stop) {
        [self setValue:[account valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

- (NSURL *)apiUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://%@.campfirenow.com", self.subdomain]];
}

- (MLLWUser *)user {
    return self.launchpadAccount.user;
}

@end
