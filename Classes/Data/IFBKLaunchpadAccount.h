#import "IFBKManagedObject.h"

@class IFBKAccount, IFBKUser;

typedef NS_ENUM(NSInteger, IFBKLaunchpadAccountType) {
    IFBKLaunchpadAccountTypeCampfire = 0,
    IFBKLaunchpadAccountTypeBasecamp,
    IFBKLaunchpadAccountTypeBasecampClassic,
    IFBKLaunchpadAccountTypeHighrise,
    IFBKLaunchpadAccountTypeBackpack,
    IFBKLaunchpadAccountTypeUnknown,
};

@interface IFBKLaunchpadAccount : IFBKManagedObject

@property (nonatomic, retain) NSString *href;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) IFBKAccount *campfireAccount;
@property (nonatomic, retain) IFBKUser *user;

/** The API access URL for this Launchpad account.
 */
@property (readonly) NSURL *hrefUrl;
@property (readonly) IFBKLaunchpadAccountType type;

+ (NSDictionary *)accountTypeMappings;

@end

@interface IFBKLaunchpadAccount (Finders)

+ (NSArray *)campfireAccounts;

@end