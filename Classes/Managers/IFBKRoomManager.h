#import <Foundation/Foundation.h>

@class IFBKCFRoom, IFBKUser, IFBKCFMessage, IFBKMessageSet;

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
@property (readonly) IFBKMessageSet *messages;

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
 *
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)startStreamingMessages:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/** Kills the streaming client.
 */
- (void)stopStreamingMessages;

/** Locks or unlocks this room, based on the boolean flag passed in.
 *
 *  @param isLocked if `YES`, the room will get locked. If `NO`, the room will get unlocked.
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)toggleRoomLock:(BOOL)isLocked success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/** Enters the room.
 *
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)joinRoom:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/** Leaves the room.
 *
 *  @param success A block to be called upon success.
 *  @param failure A block to be called upon failure.
 */
- (void)leaveRoom:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/** Gets a message for a given section and row - in other words, an `NSIndexPath`.
 *
 *  @param indexPath The index path for which to store the message.
 *  @returns The Campfire message.
 */
- (IFBKCFMessage *)messageAtIndexPath:(NSIndexPath *)indexPath;

/** Gets the user belonging to the messages at a given section.
 *
 *  @param section The section for which to retrieve the user.
 *  @returns The user object for that section.
 */
- (IFBKUser *)userForSection:(NSInteger)section;

/** Gets the array of messages for a given section.
 *
 *  @param section The section for which to retrieve messages.
 *  @returns The array of messages at that section.
 */
- (NSArray *)messagesForSection:(NSInteger)section;

/** Gets the number of sections for the loaded messages.
 *
 *  @returns The number of sections.
 */
- (NSInteger)numberOfMessageSections;

@end
