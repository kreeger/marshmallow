#import "BDKAPIClient.h"

@interface BDKLaunchpadClient : BDKAPIClient

/** Grabs a singleton instance of the adapter so manual requests can be made.
 *  @returns singleton instance.
 */
+ (id)sharedInstance;

+ (NSURL *)launchpadURL;

+ (void)getAccessTokenForVerificationCode:(NSString *)verificationCode
                                  success:(SuccessBlock)success
                                  failure:(FailureBlock)failure;

@end
