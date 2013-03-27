#import "BDKAPIClient.h"

@class BDKCFAccount, BDKCFUser, BDKCFRoom;

typedef void (^AccountBlock)(BDKCFAccount *account);
typedef void (^UserBlock)(BDKCFUser *user);
typedef void (^RoomBlock)(BDKCFRoom *room);

@interface BDKCampfireClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns singleton instance.
 */
+ (id)sharedInstance;

+ (void)getCurrentAccount:(AccountBlock)success failure:(FailureBlock)failure;

+ (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure;
+ (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure;
+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure;

+ (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure;
+ (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure;

@end
