#import "BDKAPIClient.h"

@class BDKCFAccount, BDKCFUser, BDKCFRoom, BDKCFMessage, BDKCFUpload;

typedef void (^AccountBlock)(BDKCFAccount *account);
typedef void (^UserBlock)(BDKCFUser *user);
typedef void (^RoomBlock)(BDKCFRoom *room);
typedef void (^MessageBlock)(BDKCFMessage *message);
typedef void (^UploadBlock)(BDKCFUpload *upload);

/** The big kahuna. This manages all inbound and outbound communication with 37signals' Campfire API.
 */
@interface BDKCampfireClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns A singleton instance.
 */
+ (id)sharedInstance;

#pragma mark - Account methods

/** Fetches info about the current account.
 *  http://b.kree.gr/14wb8bK
 *  
 *  @param success A block to be called upon completion; contains a reference to the retrieved BDKCFAccount.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
+ (void)getCurrentAccount:(AccountBlock)success failure:(FailureBlock)failure;

#pragma mark - Message methods

/** Sends a new message with the currently authenticated user as the sender.
 *  http://b.kree.gr/Z0b6Ry
 *
 *  @param message A message instance with a body and a message type.
 *  @param roomId The Campfire API room identifier where the message will be posted.
 *  @param success A block to be called upon completion; contains a reference to the full created BDKCFMessage.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
+ (void)postMessage:(BDKCFMessage *)message
             toRoom:(NSNumber *)roomId
            success:(MessageBlock)success
            failure:(FailureBlock)failure;

/** Returns a collection of 100 recent messages in the room.
 *  http://b.kree.gr/Z0bu2D
 *
 *  @param roomId The Campfire API room identifier for which to retrieve messages.
 *  @param sinceMessageId The Campfire API message identifier after which messages should be retrieved. Can be nil.
 *  @param success A block to be called upon completion; contains a list of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
+ (void)getMessagesForRoom:(NSNumber *)roomId
            sinceMessageId:(NSNumber *)sinceMessageId
                   success:(ArrayBlock)success
                   failure:(FailureBlock)failure;

/** Returns a collection of recent messages in the room.
 *  http://b.kree.gr/Z0bu2D
 *
 *  @param roomId The Campfire API room identifier for which to retrieve messages.
 *  @param limit The maximum number of messages to retrieve; max is 100. Can be nil.
 *  @param sinceMessageId The Campfire API message identifier after which messages should be retrieved. Can be nil.
 *  @param success A block to be called upon completion; contains a list of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
+ (void)getMessagesForRoom:(NSNumber *)roomId
                     limit:(NSInteger)limit
            sinceMessageId:(NSNumber *)sinceMessageId
                   success:(ArrayBlock)success
                   failure:(FailureBlock)failure;

/** Marks a message to be highlighted in the room's transcript.
 *  http://b.kree.gr/Z0dAiM
 *
 *  @param messageId the Campfire API of the message to highlight.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
+ (void)highlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure;

/** Removes a "highlighted" status from a message in the room's transcript.
 *  http://b.kree.gr/Z0dLe6
 *
 *  @param messageId the Campfire API of the message from which to remove the highlight.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
+ (void)unhighlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure;

#pragma mark - Room methods

+ (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure;

+ (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure;

+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure;

+ (void)updateRoom:(BDKCFRoom *)room success:(EmptyBlock)success failure:(FailureBlock)failure;

+ (void)joinRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

+ (void)leaveRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

+ (void)lockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

+ (void)unlockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

#pragma mark - Search methods

+ (void)searchMessagesForQuery:(NSString *)query success:(ArrayBlock)success failure:(FailureBlock)failure;

#pragma mark - Transcript methods

+ (void)getTranscriptForTodayForRoomId:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure;

+ (void)getTranscriptForRoomId:(NSNumber *)roomId
                          date:(NSDate *)date
                       success:(ArrayBlock)success
                       failure:(FailureBlock)failure;

#pragma mark - File upload methods

+ (void)uploadFile:(NSData *)file
          filename:(NSString *)filename
            toRoom:(NSNumber *)roomId
           success:(UploadBlock)success
           failure:(FailureBlock)failure;

+ (void)getRecentUploadsForRoomId:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure;

+ (void)getUploadForMessageId:(NSNumber *)messageId
                       inRoom:(NSNumber *)roomId
                      success:(UploadBlock)success
                      failure:(FailureBlock)failure;

#pragma mark - User methods

+ (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure;

+ (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure;

@end
