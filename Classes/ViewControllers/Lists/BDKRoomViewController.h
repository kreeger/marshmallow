#import "BDKCollectionViewController.h"

@class IFBKRoomManager;

/** Displays a Campfire room with messages.
 */
@interface BDKRoomViewController : BDKCollectionViewController

/** The room manager used by this view controller.
 */
@property (readonly) IFBKRoomManager *roomManager;

/** An initializer that takes a IFBKRoomManager and sets everything up all nice.
 *  @param roomManager The room manager to be userd in this view controller.
 *  @return An instance of self.
 */
+ (instancetype)vcWithRoomManager:(IFBKRoomManager *)roomManager;

@end
