#import "BDKAPIClient.h"

@class BDKLPAuthorizationData;

typedef void (^TokenSuccessBlock)(NSString *accessToken, NSString *refreshToken, NSDate *expiresAt);
typedef void (^AuthDataBlock)(BDKLPAuthorizationData *authData);

@interface BDKLaunchpadClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns singleton instance.
 */
+ (id)sharedInstance;

+ (NSURL *)launchpadURL;

+ (void)getAccessTokenForVerificationCode:(NSString *)verificationCode
                                  success:(TokenSuccessBlock)success
                                  failure:(FailureBlock)failure;

+ (void)getAuthorization:(AuthDataBlock)success failure:(FailureBlock)failure;

@end
