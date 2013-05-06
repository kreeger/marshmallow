#import "BDKViewController.h"

@class IFBKUser;

/** Presents data on a given user.
 */
@interface BDKUserViewController : BDKViewController

/** The user for this view.
 */
@property (readonly) IFBKUser *user;

/** Initializes the view controller for a user.
 *  @param user The user with which to initialize this view controller.
 *  @returns An instance of self.
 */
+ (id)vcWithIFBKUser:(IFBKUser *)user;

@end
