#import "BDKAPIClient.h"

@class BDKCFAccount, BDKCFUser, BDKCFRoom, BDKCFMessage, BDKCFUpload;

typedef void (^AccountBlock)(BDKCFAccount *account);
typedef void (^UserBlock)(BDKCFUser *user);
typedef void (^RoomBlock)(BDKCFRoom *room);
typedef void (^MessageBlock)(BDKCFMessage *message);

@interface BDKCampfireClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns singleton instance.
 */
+ (id)sharedInstance;

#pragma mark - Account methods

+ (void)getCurrentAccount:(AccountBlock)success failure:(FailureBlock)failure;

#pragma mark - Message methods

+ (void)postMessage:(BDKCFMessage *)message toRoom:(NSNumber *)roomId
            success:(MessageBlock)success failure:(FailureBlock)failure;
+ (void)getMessagesForRoom:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure;

#pragma mark - Room methods

+ (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure;
+ (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure;
+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure;

#pragma mark - User methods

+ (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure;
+ (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure;

@end
