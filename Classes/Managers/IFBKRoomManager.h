#import <Foundation/Foundation.h>

@class IFBKCFRoom, IFBKUser, IFBKCFMessage;

/** Handles uh, room stuff. Ask me later.
 */
@interface IFBKRoomManager : NSObject

/** The room managed by this manager.
 */
@property (readonly) IFBKCFRoom *room;

/** The user profile used with this manager.
 */
@property (readonly) IFBKUser *user;

/** The messages loaded for the room.
 */
@property (readonly) NSMutableArray *messages;

/** A block to be called upon message receipt; associated views should probably be reloaded.
 */
@property (copy, nonatomic) void(^didReceiveMessageBlock)(IFBKCFMessage *message);

/** Initializes a version of this room manager with a given room and user.
 *
 *  @param room A Campfire room.
 *  @param user The user that has access to this room.
 *  @returns An instance of self.
 */
+ (id)roomManagerWithRoom:(IFBKCFRoom *)room user:(IFBKUser *)user;

/** Loads the most recent 100 messages in the room and stores them. Should be called upon entering the room.
 *
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)loadRecentHistory:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/** Loads the most recent messages available in the room since a particular message and stores them. Should be called
 *  periodically if streaming is not being used.
 *
 *  @param messageId The message ID after which messages should be retrieved.
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)loadHistorySinceMessageId:(NSNumber *)messageId
                          success:(void (^)(void))success
                          failure:(void (^)(NSError *error))failure;

/** Fires up the streaming client.
 */
- (void)startStreamingMessages;

/** Kills the streaming client.
 */
- (void)stopStreamingMessages;

@end
