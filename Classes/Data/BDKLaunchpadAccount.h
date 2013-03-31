#import "_BDKLaunchpadAccount.h"

typedef enum {
    BDKLaunchpadAccountTypeCampfire = 0,
    BDKLaunchpadAccountTypeBasecamp,
    BDKLaunchpadAccountTypeBasecampClassic,
    BDKLaunchpadAccountTypeHighrise,
    BDKLaunchpadAccountTypeBackpack,
    BDKLaunchpadAccountTypeUnknown,
} BDKLaunchpadAccountType;

/** A Core Data representation of a 37signals Launchpad account.
 */
@interface BDKLaunchpadAccount : _BDKLaunchpadAccount {}

@property (readonly) NSURL *hrefUrl;
@property (readonly) BDKLaunchpadAccountType type;

+ (NSDictionary *)accountTypeMappings;

@end
