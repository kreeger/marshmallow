#import <UIKit/UIKit.h>

#define kBDKMessageCellID @"BDKMessageCell"

typedef enum {
    BDKMessageCellPositionSingle = 0,
    BDKMessageCellPositionTop,
    BDKMessageCellPositionMiddle,
    BDKMessageCellPositionBottom,
} BDKMessageCellPosition;

@class IFBKCFMessage;

/** A table view cell intended to represent a message in a room.
 */
@interface BDKMessageCell : UITableViewCell

@property (strong, nonatomic) IFBKCFMessage *message;
@property (readonly) UILabel *typeLabel;
@property (readonly) UILabel *bodyLabel;
@property (readonly) UILabel *timestampLabel;

@end
