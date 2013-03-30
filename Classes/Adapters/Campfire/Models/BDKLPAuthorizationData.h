#import "BDKCFModel.h"

@class BDKLPIdentity;

/** A representation of the information that comes back when a user authenticates against Launchpad.
 */
@interface BDKLPAuthorizationData : BDKCFModel

/** A list of the accounts the user has access to (Campfires, Basecamps, Backpacks, etc.).
 */
@property (strong, nonatomic) NSArray *accounts;

/** The date and time at which the current user's OAuth token expires.
 */
@property (strong, nonatomic) NSDate *expiresAt;

/** The identity object representing the current user (contains first/last name, email, etc.).
 */
@property (strong, nonatomic) BDKLPIdentity *identity;

@end
