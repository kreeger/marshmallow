#import "BDKCFModel.h"

/** An internal representation of a Campfire room.
 */
@interface BDKCFRoom : BDKCFModel

/** The 37signals Campfire API room identifier.
 */
@property (strong, nonatomic) NSNumber *identifier;

/** The name of the room.
 */
@property (strong, nonatomic) NSString *name;

/** The current topic of the room.
 */
@property (strong, nonatomic) NSString *topic;

/** The maximum number of users allowed to be in a room at a time.
 */
@property (strong, nonatomic) NSNumber *membershipLimit;

/** If `YES`, the room is at maximum capacity.
 */
@property (nonatomic) BOOL full;

/** If `YES`, non-members can enter the room as well.
 */
@property (nonatomic) BOOL openToGuests;

/** A code token for the room; only present if openToGuests is `YES`.
 */
@property (strong, nonatomic) NSString *activeTokenValue;

/** The date and time when the room was created.
 */
@property (strong, nonatomic) NSDate *createdAt;

/** The date and time when the room was last updated.
 */
@property (strong, nonatomic) NSDate *updatedAt;

/** A list of all the present BDKCFUser objects in the room.
 */
@property (strong, nonatomic) NSArray *users;

@end
