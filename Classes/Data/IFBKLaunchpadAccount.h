#import "_IFBKLaunchpadAccount.h"

typedef enum {
    IFBKLaunchpadAccountTypeCampfire = 0,
    IFBKLaunchpadAccountTypeBasecamp,
    IFBKLaunchpadAccountTypeBasecampClassic,
    IFBKLaunchpadAccountTypeHighrise,
    IFBKLaunchpadAccountTypeBackpack,
    IFBKLaunchpadAccountTypeUnknown,
} IFBKLaunchpadAccountType;

/** A Core Data representation of a 37signals Launchpad account.
 */
@interface IFBKLaunchpadAccount : _IFBKLaunchpadAccount {}

/** The API access URL for this Launchpad account.
 */
@property (readonly) NSURL *hrefUrl;
@property (readonly) IFBKLaunchpadAccountType type;

+ (NSDictionary *)accountTypeMappings;

@end
