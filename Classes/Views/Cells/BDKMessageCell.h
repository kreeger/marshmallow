#import <UIKit/UIKit.h>

#define kBDKMessageCellID @"BDKMessageCell"

@class BDKCFMessage;

/** A table view cell intended to represent a message in a room.
 */
@interface BDKMessageCell : UITableViewCell

@property (strong, nonatomic) BDKCFMessage *message;
@property (readonly) UILabel *typeLabel;
@property (readonly) UILabel *bodyLabel;
@property (readonly) UILabel *timestampLabel;
@property (readonly) UILabel *senderLabel;

@end
