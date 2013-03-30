#import "BDKAPIClient.h"

@class BDKLPAuthorizationData;

typedef void (^TokenSuccessBlock)(NSString *accessToken, NSString *refreshToken, NSDate *expiresAt);
typedef void (^AuthDataBlock)(BDKLPAuthorizationData *authData);

/** An adapter for accessing the 37signals Launchpad API, used with user authentication and OAuth2.
 */
@interface BDKLaunchpadClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns the singleton instance.
 */
+ (id)sharedInstance;

/** Builds the URL for a Launchpad authentication flow, to be used with a UIWebView in retrieving a verification code.
 *  @returns a URL with the application's client key and redirect URI as parameters.
 */
+ (NSURL *)launchpadURL;

/** Calls the Launchpad API to retrieve an OAuth access token, a refresh token, and the duration of the token's life.
 *  Upon successful verification, the access token returned by the success block is also set in the adapter's
 *  authentication header for future API calls.
 * 
 *  @param verificationCode The short code returned with by the OAuth2 login action; cannot be nil.
 *  @param success A block to be called upon successful verification of the verificationCode. Will be handed the
 *                 accessToken, refreshToken, and expiresAt objects.
 *  @param failure A block to be called upon potential failure. Will be handed an error and HTTP status code.
 */
+ (void)getAccessTokenForVerificationCode:(NSString *)verificationCode
                                  success:(TokenSuccessBlock)success
                                  failure:(FailureBlock)failure;

/** Calls the Launchpad API to ensure the current access token is still good, and retrieves a list of services to which
 *  the currently-authenticated user has access.
 *
 *  @param success A block to be called upon successful verification of the verificationCode. Will be handed the
 *                 accessToken, refreshToken, and expiresAt objects.
 *  @param failure A block to be called upon potential failure. Will be handed an error and HTTP status code.
 */
+ (void)getAuthorization:(AuthDataBlock)success failure:(FailureBlock)failure;

@end
