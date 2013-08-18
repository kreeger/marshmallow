#import "BDKRoomEventCell.h"

extern NSString * const BDKMessageCellID;

/**
 A collection view cell intended to represent a message in a room.
 */
@interface BDKMessageCell : BDKRoomEventCell

/**
 Displays the body of the message.
 */
@property (readonly) UILabel *bodyLabel;

/**
 If `YES`, the message is a paste.
 */
@property (nonatomic, getter = isPaste) BOOL paste;

/**
 Handles setting the internal message text of bodyLabel.
 
 @param message The text of the message to use.
 @param timestamp The text to use for the timestamp.
 */
- (void)setMessage:(NSString *)message timestamp:(NSString *)timestamp;

@end
