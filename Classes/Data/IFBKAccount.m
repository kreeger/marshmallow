#import "IFBKAccount.h"
#import "BDKCFAccount.h"

@implementation IFBKAccount

- (void)updateWithBDKCFModel:(BDKCFModel *)model {
    BDKCFAccount *account = (BDKCFAccount *)model;
    NSArray *attributes = @[@"identifier", @"name", @"subdomain", @"plan", @"ownerIdentifier", @"storage",
                            @"createdAt", @"updatedAt"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[account valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

#pragma mark - Properties

- (NSURL *)apiUrl
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://%@.campfirenow.com", self.subdomain]];
}

@end
