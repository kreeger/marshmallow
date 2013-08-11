#import <UIKit/UIKit.h>

extern NSString * const BDKMessageCellID;

/**
 A collection view cell intended to represent a message in a room.
 */
@interface BDKMessageCell : UICollectionViewCell

@property (readonly) UILabel *bodyLabel;
@property (readonly) UILabel *timestampLabel;

/**
 Handles setting the internal message text of bodyLabel.
 
 @param messageText The text of the message to use.
 @param timestampText The text to use for the timestamp.
 */
- (void)setMessageText:(NSString *)messageText timestampText:(NSString *)timestampText;

@end
