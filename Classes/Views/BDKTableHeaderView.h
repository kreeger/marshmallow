#import <UIKit/UIKit.h>

#define kBDKTableHeaderViewHeight 22

/**
 Replaces a standard gray-teal table header view (for plain table views).
 */
@interface BDKTableHeaderView : UIView

/**
 The title string to show in this table header view.
 */
@property (strong, nonatomic) NSString *title;

/**
 Initializes a header view with a title and width.
 
 @param title The title with which to initialize this view.
 @param width The width for which to initialize this view.
 @return An instance of the header view.
 */
+ (instancetype)headerWithTitle:(NSString *)title width:(CGFloat)width;

/**
 Initializes a header view with a title and width.
 
 @param title The title with which to initialize this view.
 @param width The width for which to initialize this view.
 @return An instance of the header view.
 */
- (instancetype)initWithTitle:(NSString *)title width:(CGFloat)width;

@end
