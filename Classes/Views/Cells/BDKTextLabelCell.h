#import <UIKit/UIKit.h>

extern NSString * const BDKTextLabelCellID;

/**
 A collection view cell intended to represent junk until I get it fixed.
 */
@interface BDKTextLabelCell : UICollectionViewCell

@property (readonly) UILabel *bodyLabel;

/**
 Handles setting the internal message text of bodyLabel.
 
 @param bodyText The text of the message to use.
 */
- (void)setBodyText:(NSString *)bodyText;

@end
