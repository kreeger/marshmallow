#import "MLLWManagedObject.h"

typedef NS_ENUM(NSInteger, MLLWUserType) {
    MLLWUserTypeMember = 0,
    MLLWUserTypeGuest,
    MLLWUserTypeUnknown,
};

@class MLLWLaunchpadAccount;

@interface MLLWUser : MLLWManagedObject

@property (nonatomic) BOOL admin;
@property (nonatomic, retain) NSString *apiAuthToken;
@property (nonatomic, retain) NSString *avatarUrl;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSString *emailAddress;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) MLLWLaunchpadAccount *launchpadAccount;

/**
 The custom type enum value of the user; can be MLLWUserTypeMember or MLLWUserTypeGuest.
 */
@property (readonly) MLLWUserType userType;

/**
 Returns `YES` if the user record is associated with a Launchpad account.
 */
@property (readonly) BOOL isCurrentUser;

/**
 The actual-url version of this model's avatarUrl string.
 */
@property (readonly) NSURL *avatarUrlValue;

/**
 A dictionary representation of internal MLLWUserType names to the text names that come from the Campfire API.
 */
+ (NSDictionary *)userTypeMappings;

@end
