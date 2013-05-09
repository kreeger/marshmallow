#import <Foundation/Foundation.h>

@class BDKCFRoom;

/** Handles uh, room stuff. Ask me later.
 */
@interface IFBKRoomManager : NSObject

/** The room managed by this manager.
 */
@property (readonly) BDKCFRoom *room;

/** Initializes a version of this room manager with a given room.
 *
 *  @param room A Campfire room.
 *  @returns An instance of self.
 */
+ (id)roomManagerWithRoom:(BDKCFRoom *)room;


- (void)startStreamingMessages;

@end
