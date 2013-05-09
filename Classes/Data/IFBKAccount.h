#import "_IFBKAccount.h"

@class IFBKUser;

/** A Core Data representation of a Campfire account.
 */
@interface IFBKAccount : _IFBKAccount {}

@property (readonly) NSURL *apiUrl;
@property (readonly) IFBKUser *user;

@end
