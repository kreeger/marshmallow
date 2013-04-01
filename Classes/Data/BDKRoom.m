#import "BDKRoom.h"
#import "BDKCFRoom.h"

@implementation BDKRoom

- (void)updateWithBDKCFModel:(BDKCFModel *)model
{
    BDKCFRoom *room = (BDKCFRoom *)model;
    NSArray *attributes = @[@"identifier", @"name", @"topic", @"membershipLimit", @"full", @"openToGuests",
                            @"activeTokenValue", @"createdAt", @"updatedAt"];
    [attributes each:^(NSString *attribute) {
        [self setValue:[room valueForKeyPath:attribute] forKeyPath:attribute];
    }];

    // What to do about room.users?
}

@end
