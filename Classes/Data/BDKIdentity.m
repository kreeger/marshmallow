#import "BDKIdentity.h"
#import "BDKLPIdentity.h"

@implementation BDKIdentity

- (void)updateWithBDKCFModel:(BDKCFModel *)model {
    BDKLPIdentity *identity = (BDKLPIdentity *)model;
    NSArray *attributes = @[@"identifier", @"emailAddress", @"firstName", @"lastName"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[identity valueForKeyPath:attribute] forKeyPath:attribute];
    }];
}

@end
