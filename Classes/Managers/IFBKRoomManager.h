#import <Foundation/Foundation.h>

@class BDKCFRoom, IFBKUser;

/** Handles uh, room stuff. Ask me later.
 */
@interface IFBKRoomManager : NSObject

/** The room managed by this manager.
 */
@property (readonly) BDKCFRoom *room;

/** The user profile used with this manager.
 */
@property (readonly) IFBKUser *user;

/** Initializes a version of this room manager with a given room and user.
 *
 *  @param room A Campfire room.
 *  @param user The user that has access to this room.
 *  @returns An instance of self.
 */
+ (id)roomManagerWithRoom:(BDKCFRoom *)room user:(IFBKUser *)user;

/** Fires up the streaming client.
 */
- (void)startStreamingMessages;

@end
