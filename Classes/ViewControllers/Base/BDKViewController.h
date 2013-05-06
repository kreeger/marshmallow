#import <UIKit/UIKit.h>

@class IFBKUser, BDKCampfireClient;

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
@property (readonly) IFBKUser *currentUser;

@property (readonly) CGRect frame;
@property (readonly) CGRect bounds;

+ (id)vc;
+ (id)vcWithIdentifier:(NSString *)identifier;
- (id)initWithIdentifier:(NSString *)identifier;


@end
