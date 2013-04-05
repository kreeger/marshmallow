#import "BDKViewController.h"

@class BDKUser;

/** Presents data on a given user.
 */
@interface BDKUserViewController : BDKViewController

/** The user for this view.
 */
@property (readonly) BDKUser *user;

/** Initializes the view controller for a user.
 *  @param user The user with which to initialize this view controller.
 *  @returns An instance of self.
 */
+ (id)vcWithBDKUser:(BDKUser *)user;

@end
