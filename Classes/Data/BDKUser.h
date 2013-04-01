#import "_BDKUser.h"

typedef enum {
    BDKUserTypeMember = 0,
    BDKUserTypeGuest,
    BDKUserTypeUnknown,
} BDKUserType;

/** A Core Data representation of a Campfire user.
 */
@interface BDKUser : _BDKUser {}

/** The custom type enum value of the user; can be BDKUserTypeMember or BDKUserTypeGuest.
 */
@property (readonly) BDKUserType userType;

/** The actual-url version of this model's avatarUrl string.
 */
@property (readonly) NSURL *avatarUrlValue;

/** A dictionary representation of internal BDKUserType names to the text names that come from the Campfire API.
 */
+ (NSDictionary *)userTypeMappings;

@end
