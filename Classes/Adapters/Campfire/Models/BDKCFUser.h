#import "BDKCFModel.h"

typedef enum {
    BDKCFUserTypeMember = 0,
    BDKCFUserTypeGuest,
} BDKCFUserType;

@interface BDKCFUser : BDKCFModel

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *emailAddress;
@property (nonatomic) BOOL admin;
@property (strong, nonatomic) NSDate *createdAt;
@property (nonatomic) BDKCFUserType type;
@property (strong, nonatomic) NSURL *avatarUrl;

@end
