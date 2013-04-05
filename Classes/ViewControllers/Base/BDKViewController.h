#import <UIKit/UIKit.h>

@class BDKUser, BDKCampfireClient;

/** A base implementation of a view controller; not much to see here.
 */
@interface BDKViewController : UIViewController

/** A string identifier this controller can use for analytics, naming, etc.
 */
@property (strong, nonatomic) NSString *identifier;

/** If `YES`, this view is presented modally.
 */
@property (nonatomic) BOOL isModal;

/** A block to be called upon dismissal of a modal.
 */
@property (copy, nonatomic) VoidBlock modalDismissalBlock;

/** A handy reference to the current user's identifier.
 */
@property (readonly) NSNumber *currentUserId;

/** A reference to the current user.
 */
@property (readonly) BDKUser *currentUser;

/** A handy reference to the App Delegate's Campfire Client class.
 */
@property (readonly) BDKCampfireClient *campfireClient;

@property (readonly) CGRect frame;
@property (readonly) CGRect bounds;

+ (id)vc;
+ (id)vcWithIdentifier:(NSString *)identifier;
- (id)initWithIdentifier:(NSString *)identifier;


@end
