#import "_IFBKUser.h"

typedef enum {
    IFBKUserTypeMember = 0,
    IFBKUserTypeGuest,
    IFBKUserTypeUnknown,
} IFBKUserType;

/** A Core Data representation of a Campfire user.
 */
@interface IFBKUser : _IFBKUser {}

/** The custom type enum value of the user; can be IFBKUserTypeMember or IFBKUserTypeGuest.
 */
@property (readonly) IFBKUserType userType;

/** Returns `YES` if the user record is associated with a Launchpad account.
 */
@property (readonly) BOOL isCurrentUser;

/** The actual-url version of this model's avatarUrl string.
 */
@property (readonly) NSURL *avatarUrlValue;

/** A dictionary representation of internal IFBKUserType names to the text names that come from the Campfire API.
 */
+ (NSDictionary *)userTypeMappings;

@end
