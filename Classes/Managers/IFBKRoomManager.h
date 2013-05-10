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

/** The messages loaded for the room.
 */
@property (readonly) NSMutableArray *messages;

/** Initializes a version of this room manager with a given room and user.
 *
 *  @param room A Campfire room.
 *  @param user The user that has access to this room.
 *  @returns An instance of self.
 */
+ (id)roomManagerWithRoom:(BDKCFRoom *)room user:(IFBKUser *)user;

/** Loads the most recent 100 messages in the room and stores them. Should be called upon entering the room.
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)loadRecentHistory:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/** Fires up the streaming client.
 */
- (void)startStreamingMessages;

/** Kills the streaming client.
 */
- (void)stopStreamingMessages;

@end
