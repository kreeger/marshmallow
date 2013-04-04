#import "BDKCollectionViewController.h"

@class BDKRoom;

/** Displays a Campfire room with messages.
 */
@interface BDKRoomViewController : BDKCollectionViewController

/** The room displayed by this view controller.
 */
@property (readonly) BDKRoom *room;

/** An initializer that takes a BDKRoom and sets everything up all nice.
 *  @param room The room to be displayed in this view controller.
 *  @returns An instance of self.
 */
+ (id)vcWithRoom:(BDKRoom *)room;

@end
