#import "BDKCampfireClient.h"
#import "BDKAPIKeyManager.h"
#import "NSString+BDKKit.h"
#import <AFNetworking/AFHTTPRequestOperation.h>

@implementation BDKCampfireClient

#pragma mark - Initialization and singleton

+ (id)sharedInstance
{
    static BDKCampfireClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BDKCampfireClient alloc] initWithBaseURL:nil];
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken];
        if (token) [__sharedInstance setAuthorizationHeaderWithToken:token];
    });
    return __sharedInstance;
}

+ (void)cancelRequestsWithPrefix:(NSString *)prefix
{
    NSArray *queue = [[self sharedInstance] operationQueue].operations;
    NSString *requestMatch = [NSString stringWithFormat:@"%@%@", [self baseURL], prefix];
    [queue each:^(AFHTTPRequestOperation *operation) {
        if ([operation.request.URL.description hasPrefix:requestMatch]) [operation cancel];
    }];
}

#pragma mark - Account methods

+ (void)getCurrentAccount:(AccountBlock)success failure:(FailureBlock)failure
{
    
}

#pragma mark - User methods

+ (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure
{
    
}

+ (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure
{

}

#pragma mark - Room methods

+ (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure
{

}

+ (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure
{

}

+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure
{

}

@end
