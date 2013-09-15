#import "IFBKRoomManager+UIKit.h"
#import <UIKit/UITableView.h>

@implementation IFBKRoomManager (UIKit)

- (IFBKCFMessage *)messageForIndexPath:(NSIndexPath *)indexPath {
    return [self messageForSection:indexPath.section row:indexPath.row];
}

@end
