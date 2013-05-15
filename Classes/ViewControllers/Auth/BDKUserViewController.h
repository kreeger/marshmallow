#import "BDKViewController.h"

/** Presents data on a given user.
 */
@interface BDKUserViewController : BDKViewController

/** The user for this view.
 */
@property (readonly) IFBKUser *user;

/** Initializes the view controller for a user facade.
 *  @param user The user for which to initialize this view controller.
 *  @returns An instance of self.
 */
+ (id)vcWithUser:(IFBKUser *)user;

@end
