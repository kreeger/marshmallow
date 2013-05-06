#import <Foundation/Foundation.h>

/** A manager class for managing multiple Launchpad accounts, specifically for Campfire.
 */
@interface IFBKAccountsManager : NSObject

/** The list of Campfire-specific 37signals Launchpad accounts.
 */
@property (strong, nonatomic) NSArray *launchpadAccounts;

/** The list of Campfire accounts.
 */
@property (strong, nonatomic) NSArray *campfireAccounts;

/** A dictionary of Campfire rooms, with account names as keys.
 */
@property (strong, nonatomic) NSDictionary *rooms;

/** Sets up the Launchpad adapters with the proper OAuth keys.
 *
 *  @param clientId The OAuth client ID.
 *  @param clientSecret The OAuth client secret key.
 *  @param redirectUri The OAuth redirect URI, which is passed in as a post-authentication callback.
 */
- (void)configureLaunchpadWithClientId:(NSString *)clientId
                          clientSecret:(NSString *)clientSecret
                           redirectUri:(NSString *)redirectUri;

/** Sets up the Launchpad adapter with the proper access token.
 *
 *  @param accessToken The OAuth access token for a user.
 */
- (void)setAccessToken:(NSString *)accessToken;

/** Ensures the current access token is up-to-date and refreshes Launchpad accounts.
 *
 *  @param completion Will be passed the list of rooms upon completion.
 *  @param failure Will be passed an error upon failure.
 */
- (void)refreshTokenAndAccounts:(void (^)(void))completion failure:(void (^)(NSError *error))failure;

- (void)getAccountData:(void (^)(NSArray *accounts))completion failure:(void (^)(NSError *error))failure;

/** Initiates a remote fetch of the rooms belonging to each of the various accounts passed in.
 * 
 *  @param completion Will be passed the list of rooms upon completion.
 *  @param failure Will be passed an error upon failure.
 */
- (void)getRooms:(void (^)(NSDictionary *rooms))completion failure:(void (^)(NSError *error))failure;

@end
