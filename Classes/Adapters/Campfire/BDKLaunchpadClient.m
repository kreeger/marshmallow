#import "BDKLaunchpadClient.h"
#import "BDKAPIKeyManager.h"
#import "NSString+BDKKit.h"

#import <AFNetworking/AFHTTPRequestOperation.h>

@implementation BDKLaunchpadClient

+ (id)sharedInstance
{
    static BDKLaunchpadClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BDKLaunchpadClient alloc] initWithBaseURL:
                            [@"https://launchpad.37signals.com/authorization" urlValue]];
    });
    return __sharedInstance;
}

+ (NSURL *)launchpadURL
{
    NSString *clientID = [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientKey];
    NSString *redirectURI = [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsRedirectURI];
    NSString *urlString = NSStringWithFormat(kBDKLaunchpadURL, clientID, redirectURI);
    return [urlString urlValue];
}

+ (void)getAccessTokenForVerificationCode:(NSString *)verificationCode
                                  success:(TokenSuccessBlock)success
                                  failure:(FailureBlock)failure
{
    NSDictionary *params = @{@"type": @"web_server",
                             @"client_id": [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientKey],
                             @"redirect_uri": [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsRedirectURI],
                             @"client_secret": [BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientSecret],
                             @"code": verificationCode.stringByUrlEncoding};
    [[self sharedInstance] postPath:@"token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *accessToken = responseObject[@"access_token"];
        NSString *refreshToken = responseObject[@"refresh_token"];
        NSTimeInterval interval = [responseObject[@"expires_in"] doubleValue];
        NSDate *expiresAt = [[NSDate date] dateByAddingTimeInterval:interval];
        success(accessToken, refreshToken, expiresAt);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

@end
