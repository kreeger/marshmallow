#import "BDKCampfireClient.h"
#import "BDKAPIKeyManager.h"
#import "NSString+BDKKit.h"
#import "BDKCFModels.h"

#import <AFNetworking/AFHTTPRequestOperation.h>

@interface BDKCampfireClient ()

+ (void)getRoomsForPath:(NSString *)path success:(ArrayBlock)success failure:(FailureBlock)failure;

+ (void)getMessagesForPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(ArrayBlock)success
                   failure:(FailureBlock)failure;

+ (void)getUploadsForPath:(NSString *)path
                   params:(NSDictionary *)params
                  success:(ArrayBlock)success
                  failure:(FailureBlock)failure;

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

#pragma mark - Private methods

+ (void)getRoomsForPath:(NSString *)path success:(ArrayBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:path
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSArray *rooms = [responseObject map:^BDKCFRoom *(NSDictionary *room) {
                                   return [BDKCFRoom modelWithDictionary:room];
                               }];
                               success(rooms);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

+ (void)getMessagesForPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(ArrayBlock)success
                   failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:path
                        parameters:params
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSArray *messages = [responseObject map:^BDKCFMessage *(NSDictionary *message) {
                                   return [BDKCFMessage modelWithDictionary:message];
                               }];
                               success(messages);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}


+ (void)getUploadsForPath:(NSString *)path
                   params:(NSDictionary *)params
                  success:(ArrayBlock)success
                  failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:path
                        parameters:params
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSArray *uploads = [responseObject map:^BDKCFUpload *(NSDictionary *upload) {
                                   return [BDKCFUpload modelWithDictionary:upload];
                               }];
                               success(uploads);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

#pragma mark - Account methods

+ (void)getCurrentAccount:(AccountBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:@"account"
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               BDKCFAccount *account = [BDKCFAccount modelWithDictionary:responseObject];
                               success(account);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

#pragma mark - Message methods

+ (void)postMessage:(BDKCFMessage *)message
             toRoom:(NSNumber *)roomId
            success:(MessageBlock)success
            failure:(FailureBlock)failure
{
    [[self sharedInstance] postPath:NSStringWithFormat(@"room/%@/speak", roomId)
                         parameters:message.asApiData
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [[self sharedInstance] postPath:NSStringWithFormat(@"messages/%@/star", messageId)
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                success();
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error, operation.response.statusCode);
                            }];
}

+ (void)unhighlightMessage:(NSNumber *)messageId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] deletePath:NSStringWithFormat(@"messages/%@/star", messageId)
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  success();
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

+ (void)getRoomForId:(NSNumber *)roomId success:(RoomBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:NSStringWithFormat(@"room/%@", roomId)
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               BDKCFRoom *room = [BDKCFRoom modelWithDictionary:responseObject];
                               success(room);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

+ (void)updateRoom:(BDKCFRoom *)room success:(EmptyBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] putPath:NSStringWithFormat(@"room/%@", room.identifier)
                        parameters:room.asApiData
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               success();
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

+ (void)joinRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] postPath:NSStringWithFormat(@"room/%@/join", roomId)
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                success();
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error, operation.response.statusCode);
                            }];
}

+ (void)leaveRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] postPath:NSStringWithFormat(@"room/%@/leave", roomId)
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                success();
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error, operation.response.statusCode);
                            }];
}

+ (void)lockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] postPath:NSStringWithFormat(@"room/%@/lock", roomId)
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                success();
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                failure(error, operation.response.statusCode);
                            }];
}

+ (void)unlockRoom:(NSNumber *)roomId success:(EmptyBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] postPath:NSStringWithFormat(@"room/%@/unlock", roomId)
                         parameters:nil
                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+ (void)getTranscriptForRoomId:(NSNumber *)roomId
                          date:(NSDate *)date
                       success:(ArrayBlock)success
                       failure:(FailureBlock)failure
{
    NSDateComponents *components = [[NSCalendar currentCalendar]
                                    components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit)
                                    fromDate:date];
    NSString *path = NSStringWithFormat(@"room/%@/transcript/%@/%@/%@", roomId,
                                        @(components.year), @(components.month), @(components.day));
    [self getMessagesForPath:path params:nil success:success failure:failure];
}

#pragma mark - File upload methods

+ (void)uploadFile:(NSData *)file
          filename:(NSString *)filename
            toRoom:(NSNumber *)roomId
           success:(UploadBlock)success
           failure:(FailureBlock)failure
{
    // We're getting the mime type here.
    CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (__bridge CFStringRef)filename,
                                                            NULL);
    NSString *mimeType = (__bridge NSString *)UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension);
    CFRelease(uti);
    void (^appendBlock)(id<AFMultipartFormData>) = ^(id<AFMultipartFormData>formData) {
        [formData appendPartWithFileData:file name:@"upload" fileName:filename mimeType:mimeType];
    };
    void (^progressBlock)(NSUInteger, long long, long long) = ^(NSUInteger written,
                                                           long long totalWritten,
                                                           long long totalToWrite) {
        NSLog(@"Sent %i of %lld bytes", written, totalToWrite);
    };
    void (^completionBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        BDKCFUpload *upload = [BDKCFUpload modelWithDictionary:responseObject];
        success(upload);
    };
    void (^failureBlock)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error, operation.response.statusCode);
    };

    NSString *path = NSStringWithFormat(@"room/%@/uploads", roomId);
    NSMutableURLRequest *request = [[self sharedInstance] multipartFormRequestWithMethod:@"POST"
                                                                                    path:path
                                                                              parameters:nil
                                                               constructingBodyWithBlock:appendBlock];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:progressBlock];
    [operation setCompletionBlockWithSuccess:completionBlock failure:failureBlock];
    [[self sharedInstance] enqueueHTTPRequestOperation:operation];
}

+ (void)getRecentUploadsForRoomId:(NSNumber *)roomId success:(ArrayBlock)success failure:(FailureBlock)failure
{
    [self getUploadsForPath:NSStringWithFormat(@"room/%@/uploads", roomId) params:nil success:success failure:failure];
}

+ (void)getUploadForMessageId:(NSNumber *)messageId
                       inRoom:(NSNumber *)roomId
                      success:(UploadBlock)success
                      failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:NSStringWithFormat(@"room/%@/messages/%@/upload", roomId, messageId)
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               BDKCFUpload *upload = [BDKCFUpload modelWithDictionary:responseObject];
                               success(upload);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

#pragma mark - User methods

+ (void)getUserForId:(NSNumber *)userId success:(UserBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:NSStringWithFormat(@"users/%@", userId)
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               BDKCFUser *user = [BDKCFUser modelWithDictionary:responseObject];
                               success(user);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

+ (void)getCurrentUser:(UserBlock)success failure:(FailureBlock)failure
{
    [[self sharedInstance] getPath:@"users/me"
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               BDKCFUser *user = [BDKCFUser modelWithDictionary:responseObject];
                               success(user);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error, operation.response.statusCode);
                           }];
}

@end
