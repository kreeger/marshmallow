#import <UIKit/UIKit.h>

@class MLLWAccountManager;

/** 
 The Marshmallow application delegate. Not much to see here.
 */
@interface BDKAppDelegate : UIResponder <UIApplicationDelegate>

/**
 The application window.
 */
@property (strong, nonatomic) UIWindow *window;

/**
 An instance of the Accounts manager.
 */
@property (strong, nonatomic) MLLWAccountManager *accountManager;

/**
 Talks to Campfire and Launchpad account managers to refresh the local data set.
 */
- (void)refreshUserData;

/**
 Removes the saved user and redirects back to the login controller.
 */
- (void)signoutCurrentUser;

@end
