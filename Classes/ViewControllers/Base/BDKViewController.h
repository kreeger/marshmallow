#import <UIKit/UIKit.h>
#import "BDKTypedefs.h"

@class MLLWUser, IFBKCampfireClient, MLLWAccountManager;

/**
 A base implementation of a view controller; not much to see here.
 */
@interface BDKViewController : UIViewController

/**
 A string identifier this controller can use for analytics, naming, etc.
 */
@property (strong, nonatomic) NSString *identifier;

/**
 If `YES`, this view is presented modally.
 */
@property (nonatomic) BOOL isModal;

/**
 A block to be called upon dismissal of a modal.
 */
@property (copy, nonatomic) VoidBlock modalDismissalBlock;

/**
 A reference to the app delegate's account manager.
 */
@property (readonly) MLLWAccountManager *accountManager;

+ (instancetype)vcWithIdentifier:(NSString *)identifier;
- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
