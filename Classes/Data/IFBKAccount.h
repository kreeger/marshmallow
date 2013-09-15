#import "IFBKManagedObject.h"

@class IFBKLaunchpadAccount, IFBKUser;

/** A Core Data representation of a Campfire account.
 */
@interface IFBKAccount : IFBKManagedObject

@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *ownerIdentifier;
@property (nonatomic, retain) NSString *plan;
@property (nonatomic) int64_t storage;
@property (nonatomic, retain) NSString *subdomain;
@property (nonatomic, retain) NSString *timeZone;
@property (nonatomic, retain) NSDate *updatedAt;
@property (nonatomic, retain) IFBKLaunchpadAccount *launchpadAccount;

@property (readonly) NSURL *apiUrl;
@property (readonly) IFBKUser *user;

@end
