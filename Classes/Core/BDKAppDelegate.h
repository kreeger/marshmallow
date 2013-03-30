#import <UIKit/UIKit.h>

/** The Marshmallow application delegate. Not much to see here.
 */
@interface BDKAppDelegate : UIResponder <UIApplicationDelegate>

/** The application window.
 */
@property (strong, nonatomic) UIWindow *window;

/** A shortcut to get the path to Marshmallow's documents directory.
 */
- (NSURL *)applicationDocumentsDirectory;

@end
