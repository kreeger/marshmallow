#import "BDKLaunchpadClient.h"
#import "BDKAPIKeyManager.h"
#import "NSString+BDKKit.h"

@implementation BDKLaunchpadClient

+ (id)sharedInstance {
    static BDKLaunchpadClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BDKLaunchpadClient alloc] initWithBaseURL:
                            [@"https://launchpad.37signals.com/authorization" urlValue]];
    });
    return __sharedInstance;
}

+ (NSURL *)launchpadURL {
    NSString *clientID = [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientKey];
    NSString *redirectURI = [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsRedirectURI];
    NSString *urlString = NSStringWithFormat(kBDKLaunchpadURL, clientID, redirectURI);
    return [urlString urlValue];
}

+ (void)getAccessTokenForVerificationCode:(NSString *)verificationCode
                                  success:(SuccessBlock)success
                                  failure:(FailureBlock)failure {
    NSDictionary *params = @{};
    [[self sharedInstance] getPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, 500);
    }];
}

@end
