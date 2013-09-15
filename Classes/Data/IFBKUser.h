#import "IFBKManagedObject.h"

typedef NS_ENUM(NSInteger, IFBKUserType) {
    IFBKUserTypeMember = 0,
    IFBKUserTypeGuest,
    IFBKUserTypeUnknown,
};

@class IFBKLaunchpadAccount;

@interface IFBKUser : IFBKManagedObject

@property (nonatomic) BOOL admin;
@property (nonatomic, retain) NSString *apiAuthToken;
@property (nonatomic, retain) NSString *avatarUrl;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSString *emailAddress;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) IFBKLaunchpadAccount *launchpadAccount;

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
