#import "BDKCFModel.h"

@class BDKLPIdentity;

@interface BDKLPAuthorizationData : BDKCFModel

@property (strong, nonatomic) NSArray *accounts;
@property (strong, nonatomic) NSDate *expiresAt;
@property (strong, nonatomic) BDKLPIdentity *identity;

@end
