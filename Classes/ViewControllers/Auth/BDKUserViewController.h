#import "BDKViewController.h"

/**
 Presents data on a given user.
 */
@interface BDKUserViewController : BDKViewController

/**
 The user for this view.
 */
@property (readonly) MLLWUser *user;

/**
 The block to be called when the user requests to log out.
 */
@property (copy, nonatomic) void (^userTappedLogoutBlock)(void);

/**
 Initializes the view controller for a user facade.
 
 @param user The user for which to initialize this view controller.
 @return An instance of self.
 */
+ (id)vcWithIFBKUser:(MLLWUser *)user;

@end
