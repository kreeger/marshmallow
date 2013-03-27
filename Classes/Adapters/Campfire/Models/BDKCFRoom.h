#import "BDKCFModel.h"

@interface BDKCFRoom : BDKCFModel

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *topic;
@property (strong, nonatomic) NSNumber *membershipLimit;
@property (nonatomic) BOOL full;
@property (nonatomic) BOOL openToGuests;
@property (strong, nonatomic) NSString *activeTokenValue;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSDate *updatedAt;
@property (strong, nonatomic) NSArray *users;

@end
