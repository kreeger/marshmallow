#import "BDKCampfireClient.h"
#import "BDKAPIKeyManager.h"
#import "NSString+BDKKit.h"
#import "BDKCFModels.h"

#import <AFNetworking/AFHTTPRequestOperation.h>

@interface BDKCampfireClient ()

+ (void)getRoomsForPath:(NSString *)path success:(ArrayBlock)success failure:(FailureBlock)failure;

@end

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
    [[self sharedInstance] getPath:@"account" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFAccount *account = [BDKCFAccount modelWithDictionary:responseObject];
        success(account);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

#pragma mark - Room methods

+ (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure
{
    return [self getRoomsForPath:@"rooms" success:success failure:failure];
}

+ (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure
{
    return [self getRoomsForPath:@"presence" success:success failure:failure];
}

+ (void)getRoomsForPath:(NSString *)path success:(ArrayBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *rooms = [responseObject map:^BDKCFRoom *(NSDictionary *room) {
            return [BDKCFRoom modelWithDictionary:room];
        }];
        success(rooms);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"rooms/%@", roomId);
    [[self sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFRoom *room = [BDKCFRoom modelWithDictionary:responseObject];
        success(room);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

#pragma mark - User methods

+ (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"users/%@", userId);
    [[self sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFUser *user = [BDKCFUser modelWithDictionary:responseObject];
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:@"users/me" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFUser *user = [BDKCFUser modelWithDictionary:responseObject];
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

@end
