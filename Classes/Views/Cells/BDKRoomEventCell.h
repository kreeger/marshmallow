#import <UIKit/UIKit.h>

extern NSString * const BDKRoomEventCellID;

/**
 A base collection view cell for showing room events. Containts a timestamp view.
 */
@interface BDKRoomEventCell : UICollectionViewCell

/**
 Displays the timestamp of the event displayed by the cell.
 */
@property (readonly) UILabel *timestampLabel;

/**
 Common cell layout and initialization instructions.
 */
- (void)setup;

/**
 Sets the time of the timestamp label.
 
 @param time The time to use in the timestamp label.
 */
- (void)setTime:(NSDate *)time;

@end
