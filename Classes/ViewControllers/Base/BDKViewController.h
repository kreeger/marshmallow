#import <UIKit/UIKit.h>

/** A base implementation of a view controller; not much to see here.
 */
@interface BDKViewController : UIViewController

@property (strong, nonatomic) NSString *identifier;
@property (readonly) CGRect frame;

+ (id)vcWithIdentifier:(NSString *)identifier;
- (id)initWithIdentifier:(NSString *)identifier;


@end
