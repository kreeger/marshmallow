#import "BDKCFModel.h"

typedef enum {
    BDKLPAccountTypeCampfire = 0,
    BDKLPAccountTypeBasecamp,
    BDKLPAccountTypeBasecampClassic,
    BDKLPAccountTypeHighrise,
    BDKLPAccountTypeBackpack,
    BDKLPAccountTypeUnknown,
} BDKLPAccountType;

/** The 37signals Launchpad API uses this object to associate a user's identity with one of 37signals' services.
 */
@interface BDKLPAccount : BDKCFModel

/** The 37signals Launchpad API account model identifier.
 */
@property (strong, nonatomic) NSNumber *identifier;

/** The base URL for this user's API access to the service.
 */
@property (strong, nonatomic) NSURL *hrefUrl;

/** The company name on the service's account.
 */
@property (strong, nonatomic) NSString *name;

/** The type of service this account connects to; can be BDKLPAccountTypeBasecamp, BDKLPAccountTypeCampfire, etc.
 */
@property (nonatomic) BDKLPAccountType type;

@end
