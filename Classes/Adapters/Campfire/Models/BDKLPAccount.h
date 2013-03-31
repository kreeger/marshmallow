#import "BDKCFModel.h"

/** The 37signals Launchpad API uses this object to associate a user's identity with one of 37signals' services.
 */
@interface BDKLPAccount : BDKCFModel

/** The 37signals Launchpad API account model identifier.
 */
@property (strong, nonatomic) NSNumber *identifier;

/** The base URL for this user's API access to the service.
 */
@property (strong, nonatomic) NSString *href;

/** The company name on the service's account.
 */
@property (strong, nonatomic) NSString *name;

/** The type of service this account connects to.
 */
@property (strong, nonatomic) NSString *product;

@end
