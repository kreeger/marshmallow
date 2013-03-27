#import "BDKCFModel.h"

@interface BDKCFAccount : BDKCFModel

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *subdomain;
@property (strong, nonatomic) NSString *plan;
@property (strong, nonatomic) NSNumber *ownerIdentifier;
@property (strong, nonatomic) NSString *timeZone;
@property (strong, nonatomic) NSNumber *storage;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSDate *updatedAt;

@end
