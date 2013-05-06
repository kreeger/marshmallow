#import "BDKTableViewController.h"

@class IFBKRoom;

/** Displays a Campfire room with messages.
 */
@interface BDKRoomViewController : BDKTableViewController

/** The room displayed by this view controller.
 */
@property (readonly) IFBKRoom *room;

/** An initializer that takes a BDKRoom and sets everything up all nice.
 *  @param room The room to be displayed in this view controller.
 *  @returns An instance of self.
 */
+ (id)vcWithRoom:(IFBKRoom *)room;

@end
