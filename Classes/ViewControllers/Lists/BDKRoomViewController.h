#import "BDKTableViewController.h"

@class IFBKRoomManager;

/** Displays a Campfire room with messages.
 */
@interface BDKRoomViewController : BDKTableViewController

/** The room manager used by this view controller.
 */
@property (readonly) IFBKRoomManager *roomManager;

/** An initializer that takes a IFBKRoomManager and sets everything up all nice.
 *  @param roomManager The room manager to be userd in this view controller.
 *  @returns An instance of self.
 */
+ (id)vcWithRoomManager:(IFBKRoomManager *)roomManager;

@end
