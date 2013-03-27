#import "BDKCFModel.h"

typedef enum {
    BDKLPAccountTypeCampfire = 0,
    BDKLPAccountTypeBasecamp,
    BDKLPAccountTypeBasecampClassic,
    BDKLPAccountTypeHighrise,
    BDKLPAccountTypeBackpack,
    BDKLPAccountTypeUnknown,
} BDKLPAccountType;

@interface BDKLPAccount : BDKCFModel

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSURL *hrefUrl;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) BDKLPAccountType type;

@end
