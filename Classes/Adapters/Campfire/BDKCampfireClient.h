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

#pragma mark - Account methods

/** Fetches info about the current account.
 *  https://github.com/37signals/campfire-api/blob/master/sections/account.md#get-account
 *  
 *  @param success A block to be called upon completion; contains a reference to the retrieved BDKCFAccount.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getCurrentAccount:(AccountBlock)success failure:(FailureBlock)failure;

#pragma mark - Message methods

/** Sends a new message with the currently authenticated user as the sender.
 *  https://github.com/37signals/campfire-api/blob/master/sections/messages.md#create-message
 *
 *  @param message A message instance with a body and a message type.
 *  @param roomId The Campfire API room identifier where the message will be posted.
 *  @param success A block to be called upon completion; contains a reference to the full created BDKCFMessage.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)postMessage:(BDKCFMessage *)message
             toRoom:(NSNumber *)roomId
            success:(MessageBlock)success
            failure:(FailureBlock)failure;

/** Returns a collection of 100 recent messages in the room.
 *  https://github.com/37signals/campfire-api/blob/master/sections/messages.md#get-recent-messages
 *
 *  @param roomId The Campfire API room identifier for which to retrieve messages.
 *  @param sinceMessageId The Campfire API message identifier after which messages should be retrieved. Can be nil.
 *  @param success A block to be called upon completion; contains a list of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getMessagesForRoom:(NSNumber *)roomId
            sinceMessageId:(NSNumber *)sinceMessageId
                   success:(ArrayBlock)success
                   failure:(FailureBlock)failure;

/** Returns a collection of recent messages in the room.
 *  https://github.com/37signals/campfire-api/blob/master/sections/messages.md#get-recent-messages
 *
 *  @param roomId The Campfire API room identifier for which to retrieve messages.
 *  @param limit The maximum number of messages to retrieve; max is 100. Can be nil.
 *  @param sinceMessageId The Campfire API message identifier after which messages should be retrieved. Can be nil.
 *  @param success A block to be called upon completion; contains a list of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getMessagesForRoom:(NSNumber *)roomId
                     limit:(NSInteger)limit
            sinceMessageId:(NSNumber *)sinceMessageId
                   success:(ArrayBlock)success
                   failure:(FailureBlock)failure;

/** Marks a message to be highlighted in the room's transcript.
 *  https://github.com/37signals/campfire-api/blob/master/sections/messages.md#highlight-message
 *
 *  @param messageId the Campfire API of the message to highlight.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)highlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure;

/** Removes a "highlighted" status from a message in the room's transcript.
 *  https://github.com/37signals/campfire-api/blob/master/sections/messages.md#unhighlight-message
 *
 *  @param messageId the Campfire API of the message from which to remove the highlight.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)unhighlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure;

#pragma mark - Room methods

/** Gets a list of rooms belonging to the current Campfire account.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#get-rooms
 *
 *  @param success A block to be called upon completion; contains a list of BDKCFRoom instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure;

/** Gets a list of rooms belonging to the current Campfire account in which the current user is present.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#get-rooms
 *
 *  @param success A block to be called upon completion; contains a list of BDKCFRoom instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure;

/** Gets a BDKCFRoom given its API identifier. This also includes a list of BDKCFUser instances currently in the room.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#get-room
 *
 *  @param roomId The Campfire API room identifier for the room to be retrieved.
 *  @param success A block to be called upon completion; contains a full instance of a BDKCFRoom.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure;

/** Updates a room via the Campfire API, with the ability to change the name and/or topic. Current user must be an
 *  admin to change the room's name.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#update-room
 *
 *  @param room The instance of BDKCFRoom to update.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)updateRoom:(BDKCFRoom *)room success:(EmptyBlock)success failure:(FailureBlock)failure;

/** POSTs to the Campfire API to join the current user to a room represented by the given room identifier.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#join-room
 *
 *  @param roomId The Campfire API room identifier for the room to be joined.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)joinRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

/** POSTs to the Campfire API to remove the current user from a room represented by the given room identifier.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#leave-room
 *
 *  @param roomId The Campfire API room identifier for the room to be left.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)leaveRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

/** Locks the room represented by the given API identifier; only an admin can do this.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#lock-room
 *
 *  @param roomId The Campfire API room identifier for the room to be locked.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)lockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

/** Unlocks the room represented by the given API identifier; only an admin can do this.
 *  https://github.com/37signals/campfire-api/blob/master/sections/rooms.md#unlock-room
 *
 *  @param roomId The Campfire API room identifier for the room to be unlocked.
 *  @param success A block to be called upon completion.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)unlockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure;

#pragma mark - Search methods

/** Finds all the messages across all rooms on this account containing the supplied term.
 *  https://github.com/37signals/campfire-api/blob/master/sections/search.md#search-for-term
 *
 *  @param query The text string for which to search transcripts.
 *  @param success A block to be called upon completion; contains an array of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)searchMessagesForQuery:(NSString *)query success:(ArrayBlock)success failure:(FailureBlock)failure;

#pragma mark - Transcript methods

/** Returns all BDKCFMessage instances sent to a room on the current day.
 *  https://github.com/37signals/campfire-api/blob/master/sections/transcripts.md#get-messages-for-today
 *
 *  @param roomId the room for which to retrieve BDKCFMessage instances.
 *  @param success A block to be called upon completion; contains an array of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getTranscriptForTodayForRoomId:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure;

/** Returns all BDKCFMesssage instances sent to a room on a specific date.
 *  https://github.com/37signals/campfire-api/blob/master/sections/transcripts.md#get-messages-for-a-specific-date
 *
 *  @param roomId the room for which to retrieve BDKCFMessage instances.
 *  @param date the date for which to retrieve the transcript.
 *  @param success A block to be called upon completion; contains an array of BDKCFMessage instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getTranscriptForRoomId:(NSNumber *)roomId
                          date:(NSDate *)date
                       success:(ArrayBlock)success
                       failure:(FailureBlock)failure;

#pragma mark - File upload methods

/** Generates a multi-part form upload and posts a file as a message to a given Campfire room.
 *  https://github.com/37signals/campfire-api/blob/master/sections/uploads.md#create-upload
 *
 *  @param file the data of the file to upload to the Campfire room.
 *  @param filename the filename of the file represented by the NSData in file. Extension will be used to determine the
 *                  mime type, which is also sent as part of the multi-part form data.
 *  @param roomId the Campfire API identifier for the room where the file will be posted.
 *  @param success A block to be called upon completion; contains a full instance of the BDKCFUpload.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)uploadFile:(NSData *)file
          filename:(NSString *)filename
            toRoom:(NSNumber *)roomId
           success:(UploadBlock)success
           failure:(FailureBlock)failure;

/** Gets the five (5) most recent uploads to a given Campfire room.
 *  https://github.com/37signals/campfire-api/blob/master/sections/uploads.md#get-uploads
 *
 *  @param roomId the Campfire API identifier for the room for which to retrieve recent uploads.
 *  @param success A block to be called upon completion; contains an array of BDKCFUpload instances.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getRecentUploadsForRoomId:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure;

/** Gets a single upload represented by a message identifier from a given Campfire room.
 *  https://github.com/37signals/campfire-api/blob/master/sections/uploads.md#get-upload
 *
 *  @param messageId the Campfire API identifier for the message for which to retrieve the upload.
 *  @param roomId the Campfire API identifier for the room that contains the message.
 *  @param success A block to be called upon completion; contains an instance of BDKCFUpload.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getUploadForMessageId:(NSNumber *)messageId
                       inRoom:(NSNumber *)roomId
                      success:(UploadBlock)success
                      failure:(FailureBlock)failure;

#pragma mark - User methods

/** Gets a user's information from the Campfire API given the user's API identifier.
 *  https://github.com/37signals/campfire-api/blob/master/sections/users.md#get-user
 *
 *  @param userId the Campfire API identifier for the user to retrieve.
 *  @param success A block to be called upon completion; contains an instance of BDKCFUser.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure;

/** Gets the current user's information from the Campfire API.
 *  https://github.com/37signals/campfire-api/blob/master/sections/users.md#get-self
 *
 *  @param success A block to be called upon completion; contains an instance of BDKCFUser.
 *  @param failure A block to be called upon failure; contains an NSError reference and the HTTP status code received.
 */
- (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure;

@end
