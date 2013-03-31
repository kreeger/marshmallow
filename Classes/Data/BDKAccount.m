#import "BDKAccount.h"
#import "BDKCFAccount.h"

@implementation BDKAccount

- (void)updateWithBDKCFModel:(BDKCFModel *)model {
    BDKCFAccount *account = (BDKCFAccount *)model;
    NSArray *attributes = @[@"identifier", @"name", @"subdomain", @"plan", @"ownerIdentifier", @"storage",
                            @"createdAt", @"updatedAt"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[account valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

@end
