#import "BDKCampfireClient.h"
#import "BDKAPIKeyManager.h"
#import "NSString+BDKKit.h"
#import "BDKCFModels.h"

#import <AFNetworking/AFHTTPRequestOperation.h>

@interface BDKCampfireClient ()

+ (void)getRoomsForPath:(NSString *)path success:(ArrayBlock)success failure:(FailureBlock)failure;
+ (void)getMessagesForPath:(NSString *)path params:(NSDictionary *)params
                   success:(ArrayBlock)success failure:(FailureBlock)failure;

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

#pragma mark - Message methods

+ (void)getMessagesForPath:(NSString *)path params:(NSDictionary *)params
                   success:(ArrayBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *messages = [responseObject map:^BDKCFMessage *(NSDictionary *message) {
            return [BDKCFMessage modelWithDictionary:message];
        }];
        success(messages);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)postMessage:(BDKCFMessage *)message toRoom:(NSNumber *)roomId
            success:(MessageBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/speak", roomId);
    [[self sharedInstance] postPath:path parameters:message.asApiData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFMessage *message = [BDKCFMessage modelWithDictionary:responseObject];
        success(message);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)getMessagesForRoom:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure
{
    [self getMessagesForPath:NSStringWithFormat(@"room/%@", roomId) params:nil success:success failure:failure];
}

+ (void)highlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"messages/%@/star", messageId);
    [[self sharedInstance] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)unhighlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"messages/%@/star", messageId);
    [[self sharedInstance] deletePath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

#pragma mark - Room methods

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

+ (void)getRooms:(ArrayBlock)success failure:(FailureBlock)failure
{
    return [self getRoomsForPath:@"rooms" success:success failure:failure];
}

+ (void)getPresentRooms:(ArrayBlock)success failure:(FailureBlock)failure
{
    return [self getRoomsForPath:@"presence" success:success failure:failure];
}

+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@", roomId);
    [[self sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFRoom *room = [BDKCFRoom modelWithDictionary:responseObject];
        success(room);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)updateRoom:(BDKCFRoom *)room success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@", room.identifier);
    [[self sharedInstance] putPath:path parameters:room.asApiData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)joinRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/join", roomId);
    [[self sharedInstance] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)leaveRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/leave", roomId);
    [[self sharedInstance] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)lockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/lock", roomId);
    [[self sharedInstance] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

+ (void)unlockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/unlock", roomId);
    [[self sharedInstance] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    }];
}

#pragma mark - Search methods

+ (void)searchMessagesForQuery:(NSString *)query success:(ArrayBlock)success failure:(FailureBlock)failure
{
    [self getMessagesForPath:@"search" params:@{@"q": query.stringByUrlEncoding} success:success failure:failure];
}

#pragma mark - Transcript methods

+ (void)getTranscriptForTodayForRoomId:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/transcript", roomId);
    [self getMessagesForPath:path params:nil success:success failure:failure];
}

+ (void)getTranscriptForRoomId:(NSNumber *)roomId date:(NSDate *)date success:(ArrayBlock)success failure:(FailureBlock)failure
{
    NSString *path = NSStringWithFormat(@"room/%@/transcript/%@/%@/%@", roomId, @(0), @(0), @(0));
    [self getMessagesForPath:path params:nil success:success failure:failure];
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
