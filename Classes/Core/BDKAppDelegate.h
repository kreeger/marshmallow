#import <UIKit/UIKit.h>

@class IFBKAccountsManager;

/** The Marshmallow application delegate. Not much to see here.
 */
@interface BDKAppDelegate : UIResponder <UIApplicationDelegate>

/** The application window.
 */
@property (strong, nonatomic) UIWindow *window;

/** An instance of the Accounts manager.
 */
@property (strong, nonatomic) IFBKAccountsManager *accountsManager;

/** A shortcut to get the path to Marshmallow's documents directory.
 */
- (NSURL *)applicationDocumentsDirectory;

- (void)refreshUserData;

@end
