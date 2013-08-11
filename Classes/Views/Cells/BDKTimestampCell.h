#import <UIKit/UIKit.h>

extern NSString * const BDKTimestampCellID;

/**
 Simple; only responsible for displaying a timestamp.
 */
@interface BDKTimestampCell : UICollectionViewCell

/**
 Displays the timestamp text in the center of the cell.
 */
@property (readonly) UILabel *timestampLabel;

/**
 Handles setting the internal text of timestampLabel.
 
 @param timestampText The text to use for the timestamp.
 */
- (void)setTimestampText:(NSString *)timestampText;

@end
