#import "MLLWRoomManager.h"

#import "MLLWConstants.h"
#import "MLLWCoreDataStore.h"

#import "IFBKCFUser.h"
#import "MLLWUser.h"
#import "MLLWLaunchpadAccount.h"
#import "MLLWMessageSet.h"

#import <IFBKThirtySeven/IFBKCampfireStreamingClient.h>
#import <IFBKThirtySeven/IFBKCampfireClient.h>
#import <IFBKThirtySeven/IFBKCFRoom.h>
#import <IFBKThirtySeven/IFBKCFMessage.h>
#import <BDKKit/BDKCoreDataOperation.h>

@interface MLLWRoomManager ()

/** The streaming Campfire API for downloading messages in real-time.
 */
@property (strong, nonatomic) IFBKCampfireStreamingClient *streamingClient;

/** The standard, non-streaming Campfire client.
 */
@property (strong, nonatomic) IFBKCampfireClient *apiClient;

/** Initializes a version of this room manager with a given room and user.
 *
 *  @param room A Campfire room.
 *  @param user The user that has access to this room.
 *  @return An instance of self.
 */
- (instancetype)initWithRoom:(IFBKCFRoom *)room user:(MLLWUser *)user;

/** Fetches the latest API data for a set of users.
 *  
 *  @param users The set of users.
 */
- (void)handleDataForUsers:(NSArray *)users;

@end

@implementation MLLWRoomManager

@synthesize room = _room, user = _user;

+ (instancetype)roomManagerWithRoom:(IFBKCFRoom *)room user:(MLLWUser *)user {
    return [[self alloc] initWithRoom:room user:user];
}

- (instancetype)initWithRoom:(IFBKCFRoom *)room user:(MLLWUser *)user {
    if (self = [super init]) {
        _room = room;
        _user = user;
        _messages = [MLLWMessageSet messageSet];

        // Initialize our streaming client.
        _streamingClient = [[IFBKCampfireStreamingClient alloc] initWithRoomId:_room.identifier
                                                           authorizationToken:_user.apiAuthToken];
        __weak MLLWRoomManager *unretainedSelf = self;
        [_streamingClient setMessageReceivedBlock:^(IFBKCFMessage *message) {
            BOOL result = [unretainedSelf.messages addMessage:message];
            if (result && unretainedSelf.didReceiveMessageBlock) {
                unretainedSelf.didReceiveMessageBlock(message);
            }
        }];

        // Initialize our regular API client.
        // TODO: Find a clean way to pass in the access token here. Save it to Core Data, most likely.
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:MLLWUserDefaultAccessToken];
        _apiClient = [[IFBKCampfireClient alloc] initWithBaseURL:_user.launchpadAccount.hrefUrl accessToken:token];
    }
    return self;
}

#pragma mark - Properties

- (void)setDidReceiveMessageBlock:(void (^)(IFBKCFMessage *))didReceiveMessageBlock {
    _didReceiveMessageBlock = didReceiveMessageBlock;
    __weak MLLWRoomManager *unretainedSelf = self;
    [self.streamingClient setMessageReceivedBlock:^(IFBKCFMessage *message) {
        BOOL result = [unretainedSelf.messages addMessage:message];
        if (result) {
            unretainedSelf.didReceiveMessageBlock(message);
        }
    }];
}

- (NSInteger)numberOfMessageSections {
    return [self.messages count];
}

- (NSIndexPath *)maxIndexPath {
    NSInteger maxSection = (self.numberOfMessageSections - 1);
    return [NSIndexPath indexPathForRow:([[self messagesForSection:maxSection] count] - 1) inSection:maxSection];
}

#pragma mark - Public methods

- (void)loadRoomAndHistory:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    [self loadHistorySinceMessageId:nil success:success failure:failure];
}

- (void)loadHistorySinceMessageId:(NSNumber *)messageId
                          success:(void (^)(void))success
                          failure:(void (^)(NSError *))failure {

    void (^completionBlock)(BOOL, NSError *) = ^(BOOL success, NSError *error) {
        [self.apiClient getMessagesForRoom:self.room.identifier sinceMessageId:messageId success:^(NSArray *result) {
            __block IFBKCFMessage *lastMessage = nil;
            
            NSMutableArray *users = [NSMutableArray array];
            [result enumerateObjectsUsingBlock:^(IFBKCFMessage *message, NSUInteger idx, BOOL *stop) {
                if (![self.messages addMessage:message]) return;
                if (![(NSNull *)message.userIdentifier isEqual:[NSNull null]] &&
                    ![users containsObject:message.userIdentifier]) {
                    [users addObject:message.userIdentifier];
                }
                lastMessage = message;
            }];
            
            [self handleDataForUsers:users];
            if (self.didReceiveMessageBlock) {
                self.didReceiveMessageBlock(lastMessage);
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            NSLog(@"Encountered error %i getting messages for room. Error: %@", responseCode, error);
        }];
    };
    
    [self.apiClient getRoomForId:self.room.identifier success:^(IFBKCFRoom *room) {
        [BDKCoreDataOperation performInBackgroundWithCoreDataStore:[MLLWCoreDataStore sharedInstance]
                                               backgroundOperation:^(NSManagedObjectContext *innerContext)
         {
             [room.users enumerateObjectsUsingBlock:^(IFBKCFUser *user, NSUInteger idx, BOOL *stop) {
                 [MLLWUser createOrUpdateWithModel:user inContext:innerContext];
             }];
         } completion:completionBlock];
    } failure:^(NSError *error, NSInteger responseCode) {
        NSLog(@"Encountered error %i getting room data. Error: %@", responseCode, error);
    }];
}

- (void)startStreamingMessages:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    [self.streamingClient openConnectionWithSuccess:success failure:failure];
}

- (void)stopStreamingMessages {
    [self.streamingClient closeConnection];
    NSLog(@"Streaming connection closed.");
}

- (void)toggleRoomLock:(BOOL)isLocked success:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    void (^failureBlock)(NSError *, NSInteger) = ^(NSError *error, NSInteger responseCode) {
        if (failure) {
            failure(error);
        }
    };
    
    if (isLocked) {
        [self.apiClient lockRoom:self.room.identifier success:success failure:failureBlock];
    } else {
        [self.apiClient unlockRoom:self.room.identifier success:success failure:failureBlock];
    }
}

- (void)joinRoom:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    void (^failureBlock)(NSError *, NSInteger) = ^(NSError *error, NSInteger responseCode) {
        if (failure) {
            failure(error);
        }
    };
    [self.apiClient joinRoom:self.room.identifier success:success failure:failureBlock];
}

- (void)leaveRoom:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    void (^failureBlock)(NSError *, NSInteger) = ^(NSError *error, NSInteger responseCode) {
        if (failure) {
            failure(error);
        }
    };
    [self.apiClient leaveRoom:self.room.identifier success:success failure:failureBlock];
}

- (NSString *)headerForSection:(NSInteger)section {
    return [self.messages displayDateForSection:section];
}

- (IFBKCFMessage *)messageForSection:(NSInteger)section row:(NSInteger)row {
    return [self.messages messageForSection:section row:row];
}

- (NSArray *)messagesForSection:(NSInteger)section {
    return [self.messages messagesForSection:section];
}

#pragma mark - Private methods

- (void)handleDataForUsers:(NSArray *)users {
    
    NSMutableArray *usersToFetch = [NSMutableArray arrayWithCapacity:[users count]];
    [users enumerateObjectsUsingBlock:^(NSNumber *userId, NSUInteger idx, BOOL *stop) {
        MLLWUser *found = [MLLWUser findByIdentifier:userId inContext:[NSManagedObjectContext defaultContext]];
        if (!found) {
            [usersToFetch addObject:userId];
        }
    }];

    void (^databaseHitBlock)(NSArray *) = ^(NSArray *userArray) {
        [BDKCoreDataOperation performInBackgroundWithCoreDataStore:[MLLWCoreDataStore sharedInstance]
                                               backgroundOperation:^(NSManagedObjectContext *innerContext) {
                                                   [userArray enumerateObjectsUsingBlock:^(IFBKCFUser *user, NSUInteger idx, BOOL *stop) {
                                                       [MLLWUser createOrUpdateWithModel:user inContext:innerContext];
                                                   }];
                                               } completion:nil];
    };

    NSMutableArray *fetched = [NSMutableArray arrayWithCapacity:[usersToFetch count]];
    __block int attemptCount = 0;
    [usersToFetch enumerateObjectsUsingBlock:^(NSNumber *userId, NSUInteger idx, BOOL *stop) {
        [self.apiClient getUserForId:userId success:^(IFBKCFUser *user) {
            attemptCount++;
            [fetched addObject:user];
            if (attemptCount == [usersToFetch count]) {
                databaseHitBlock(fetched);
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            attemptCount++;
            NSLog(@"Failed getting user with error %@.", error);
            if (attemptCount == [usersToFetch count]) {
                databaseHitBlock(fetched);
            }
        }];
    }];
}

@end
