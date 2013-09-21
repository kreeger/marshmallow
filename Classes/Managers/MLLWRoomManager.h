#import <Foundation/Foundation.h>

@class IFBKCFRoom, MLLWUser, IFBKCFMessage, MLLWMessageSet;

/**
 Handles uh, room stuff. Ask me later.
 */
@interface MLLWRoomManager : NSObject

/**
 The room managed by this manager.
 */
@property (readonly) IFBKCFRoom *room;

/**
 The user profile used with this manager.
 */
@property (readonly) MLLWUser *user;

/**
 The messages loaded for the room.
 */
@property (readonly) MLLWMessageSet *messages;

/**
 The number of sections for the loaded messages.
 */
@property (readonly) NSInteger numberOfMessageSections;

/**
 The maximum index path.
 */
@property (readonly) NSIndexPath *maxIndexPath;

/**
 A block to be called upon message receipt; associated views should probably be reloaded.
 */
@property (copy, nonatomic) void(^didReceiveMessageBlock)(IFBKCFMessage *message);

/**
 Initializes a version of this room manager with a given room and user.
 
 @param room A Campfire room.
 @param user The user that has access to this room.
 @return An instance of self.
 */
+ (instancetype)roomManagerWithRoom:(IFBKCFRoom *)room user:(MLLWUser *)user;

/**
 Loads the most recent 100 messages in the room and stores them, along with full room data (with users).
 Should be called upon entering the room.
 
 @param success A block to be called upon success.
 @param failure A block to be called upon failure.
 */
- (void)loadRoomAndHistory:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/**
 Loads the most recent messages available in the room since a particular message and stores them. Should be called
 periodically if streaming is not being used.
 
 @param messageId The message ID after which messages should be retrieved.
 @param success A block to be called upon success.
 @param failure A block to be called upon failure.
 */
- (void)loadHistorySinceMessageId:(NSNumber *)messageId
                          success:(void (^)(void))success
                          failure:(void (^)(NSError *error))failure;

/**
 Fires up the streaming client.
 
 @param success A block to be called upon success.
 @param failure A block to be called upon failure.
 */
- (void)startStreamingMessages:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/**
 Kills the streaming client.
 */
- (void)stopStreamingMessages;

/**
 Locks or unlocks this room, based on the boolean flag passed in.
 
 @param isLocked if `YES`, the room will get locked. If `NO`, the room will get unlocked.
 @param success A block to be called upon success.
 @param failure A block to be called upon failure.
 */
- (void)toggleRoomLock:(BOOL)isLocked success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/**
 Enters the room.
 
 @param success A block to be called upon success.
 @param failure A block to be called upon failure.
 */
- (void)joinRoom:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/**
 Leaves the room.
 
 @param success A block to be called upon success.
 @param failure A block to be called upon failure.
 */
- (void)leaveRoom:(void (^)(void))success failure:(void (^)(NSError *error))failure;

/**
 Returns a display-date-based header for a section.
 
 @param section The section at which to look up a date.
 @return A display date formatted based on the current locale.
 */
- (NSString *)headerForSection:(NSInteger)section;

/**
 Gets a message for a given section and row - in other words, an `NSIndexPath`.
 
 @param section The section for the index path for which to store the message.
 @param row The row in the second.
 @return The Campfire message.
 */
- (IFBKCFMessage *)messageForSection:(NSInteger)section row:(NSInteger)row;

/**
 Gets the array of messages for a given section.
 
 @param section The section for which to retrieve messages.
 @return The array of messages at that section.
 */
- (NSArray *)messagesForSection:(NSInteger)section;

@end
