#import "BDKViewController.h"

/**
 A standard interface for an embedded scroll view. Defines self as a UIScrollViewDelegate.
 */
@interface BDKScrollViewController : BDKViewController <UIScrollViewDelegate>

/**
 The scroll view embedded in the controller's view with an identical frame.
 */
@property (readonly) UIScrollView *scrollView;

@end
