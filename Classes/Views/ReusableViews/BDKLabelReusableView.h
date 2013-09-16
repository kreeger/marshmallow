#import <UIKit/UIKit.h>

extern NSString * const BDKLabelReusableViewID;

/**
 Displays a single label filling the width of the view. Wildly reusable.
 */
@interface BDKLabelReusableView : UICollectionReusableView

/**
 The one label to rule them all. Binding in darkness optional.
 */
@property (readonly) UILabel *label;

@end
