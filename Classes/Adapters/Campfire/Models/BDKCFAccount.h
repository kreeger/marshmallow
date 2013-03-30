#import "BDKCFModel.h"

/** A local repesentation of a Campfire account; includes information about rooms, subdomain, etc.
 */
@interface BDKCFAccount : BDKCFModel

/** The 37signals Campfire API user identifier.
 */
@property (strong, nonatomic) NSNumber *identifier;

/** The 37signals Campfire API user identifier.
 */
@property (strong, nonatomic) NSString *name;

/** The subdomain at which this service resides.
 */
@property (strong, nonatomic) NSString *subdomain;

/** The name of the plan to which this account subscribes.
 */
@property (strong, nonatomic) NSString *plan;

/** The 37signals Campfire API user identifier of the account's owner.
 */
@property (strong, nonatomic) NSNumber *ownerIdentifier;

/** The time zone where this account resides.
 */
@property (strong, nonatomic) NSString *timeZone;

/** The amount of file storage this account is using.
 */
@property (strong, nonatomic) NSNumber *storage;

/** The date and time when the account was created.
 */
@property (strong, nonatomic) NSDate *createdAt;

/** The date and time when the account was last updated.
 */
@property (strong, nonatomic) NSDate *updatedAt;

@end
