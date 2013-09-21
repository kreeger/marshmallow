#import "MLLWRoomManager+UIKit.h"
#import <UIKit/UITableView.h>

@implementation MLLWRoomManager (UIKit)

- (IFBKCFMessage *)messageForIndexPath:(NSIndexPath *)indexPath {
    return [self messageForSection:indexPath.section row:indexPath.row];
}

@end
