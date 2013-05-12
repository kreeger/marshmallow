#import <UIKit/UIKit.h>

#define kBDKMessageCellID @"BDKMessageCell"

@class BDKCFMessage;

/** A table view cell intended to represent a message in a room.
 */
@interface BDKMessageCell : UITableViewCell

@property (weak, nonatomic) BDKCFMessage *message;

@end
