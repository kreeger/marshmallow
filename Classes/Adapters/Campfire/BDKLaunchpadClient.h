#import "BDKAPIClient.h"

typedef void (^TokenSuccessBlock)(NSString *accessToken, NSString *refreshToken, NSDate *expiresAt);

@interface BDKLaunchpadClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns singleton instance.
 */
+ (id)sharedInstance;

+ (NSURL *)launchpadURL;

+ (void)getAccessTokenForVerificationCode:(NSString *)verificationCode
                                  success:(TokenSuccessBlock)success
                                  failure:(FailureBlock)failure;

@end
