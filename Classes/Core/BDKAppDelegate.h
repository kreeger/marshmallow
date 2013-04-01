#import <UIKit/UIKit.h>

@class BDKCampfireClient;

/** The Marshmallow application delegate. Not much to see here.
 */
@interface BDKAppDelegate : UIResponder <UIApplicationDelegate>

/** The application window.
 */
@property (strong, nonatomic) UIWindow *window;

/** An instance of the Campfire API client.
 */
@property (strong, nonatomic) BDKCampfireClient *campfireClient;

/** A shortcut to get the path to Marshmallow's documents directory.
 */
- (NSURL *)applicationDocumentsDirectory;

@end
