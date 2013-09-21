#import "MLLWManagedObject.h"

@class MLLWAccount, MLLWUser;

typedef NS_ENUM(NSInteger, MLLWLaunchpadAccountType) {
    MLLWLaunchpadAccountTypeCampfire = 0,
    MLLWLaunchpadAccountTypeBasecamp,
    MLLWLaunchpadAccountTypeBasecampClassic,
    MLLWLaunchpadAccountTypeHighrise,
    MLLWLaunchpadAccountTypeBackpack,
    MLLWLaunchpadAccountTypeUnknown,
};

@interface MLLWLaunchpadAccount : MLLWManagedObject

@property (nonatomic, retain) NSString *href;
@property (nonatomic, retain) NSNumber *identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) MLLWAccount *campfireAccount;
@property (nonatomic, retain) MLLWUser *user;

/**
 The API access URL for this Launchpad account.
 */
@property (readonly) NSURL *hrefUrl;
@property (readonly) MLLWLaunchpadAccountType type;

+ (NSDictionary *)accountTypeMappings;

@end

@interface MLLWLaunchpadAccount (Finders)

+ (NSArray *)campfireAccounts;

@end
