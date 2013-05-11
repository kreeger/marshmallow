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

/** The list of Campfire user profiles.
 */
@property (strong, nonatomic) NSArray *campfireUsers;

/** An array of dictionaries for Campfire rooms, with account names as keys.
 */
@property (strong, nonatomic) NSArray *rooms;

/** If this account manager has an accessToken (and it's not too old) this returns true.
 */
@property (readonly) BOOL isLoggedIn;

/** Sets up the Launchpad adapters with the proper OAuth keys.
 *
 *  @param clientId The OAuth client ID.
 *  @param clientSecret The OAuth client secret key.
 *  @param redirectUri The OAuth redirect URI, which is passed in as a post-authentication callback.
 */
- (void)configureLaunchpadWithClientId:(NSString *)clientId
                          clientSecret:(NSString *)clientSecret
                           redirectUri:(NSString *)redirectUri;

/** Calls the Launchpad API and trades in an authorization code for an OAuth token and expiration date; saves this
 *  information to the IFBKLaunchpadAccount in the Core Data store.
 *  @param authorizationCode The OAuth authorization code that came from the Launchpad page presented to the user after
 *                           they login.
 *  @param completion A block to be called upon completion.
 *  @param failure A block to be called upon failure.
 */
- (void)tradeAuthTokenDataForAuthorizationCode:(NSString *)authorizationCode
                                    completion:(void (^)(void))completion
                                       failure:(void (^)(NSError *error))failure;

/** Ensures the current access token is up-to-date and refreshes Launchpad accounts.
 *
 *  @param completion Will be passed the list of rooms upon completion.
 *  @param failure Will be passed an error upon failure.
 */
- (void)refreshLaunchpadData:(void (^)(void))completion failure:(void (^)(NSError *error))failure;

/** Initiates a remote fetch of the separate Campfire accounts available under the user's profile.
 *
 *  @param completion Will be passed the list of accounts upon completion.
 *  @param failure Will be passed an error upon failure.
 */
- (void)getAccountData:(void (^)(NSArray *accounts))completion failure:(void (^)(NSError *error))failure;

/** Initiates a remote fetch of the separate Campfire user profiles belonging to the user.
 *
 *  @param completion Will be passed the list of user profiles upon completion.
 *  @param failure Will be passed an error upon failure.
 */
- (void)getCurrentUserData:(void (^)(NSArray *accounts))completion failure:(void (^)(NSError *error))failure;

/** Initiates a remote fetch of the rooms belonging to each of the various accounts passed in.
 * 
 *  @param completion Will be passed the list of rooms upon completion.
 *  @param failure Will be passed an error upon failure.
 */
- (void)getRooms:(void (^)(NSArray *rooms))completion failure:(void (^)(NSError *error))failure;

@end
