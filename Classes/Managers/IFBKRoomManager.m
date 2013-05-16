#import "IFBKRoomManager.h"

#import <IFBKThirtySeven/IFBKCampfireStreamingClient.h>
#import <IFBKThirtySeven/IFBKCampfireClient.h>
#import <IFBKThirtySeven/IFBKCFRoom.h>
#import <IFBKThirtySeven/IFBKCFMessage.h>
#import <ObjectiveSugar/ObjectiveSugar.h>

#import "IFBKUser.h"
#import "IFBKLaunchpadAccount.h"

#import "IFBKConstants.h"

@interface IFBKRoomManager ()

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
 *  @returns An instance of self.
 */
- (id)initWithRoom:(IFBKCFRoom *)room user:(IFBKUser *)user;

/** Handles an incoming message from the Campfire API (and saves it).
 *  @param message The incoming message object.
 */
- (void)processMessageFromAPI:(IFBKCFMessage *)message;

@end

@implementation IFBKRoomManager

@synthesize room = _room, user = _user;

+ (id)roomManagerWithRoom:(IFBKCFRoom *)room user:(IFBKUser *)user {
    return [[self alloc] initWithRoom:room user:user];
}

- (id)initWithRoom:(IFBKCFRoom *)room user:(IFBKUser *)user {
    if (self = [super init]) {
        _room = room;
        _user = user;
        _messages = [NSMutableArray array];

        // Initialize our streaming client.
        _streamingClient = [[IFBKCampfireStreamingClient alloc] initWithRoomId:_room.identifier
                                                           authorizationToken:_user.apiAuthToken];
        __weak IFBKRoomManager *unretainedSelf = self;
        [_streamingClient setMessageReceivedBlock:^(IFBKCFMessage *message) {
            [unretainedSelf processMessageFromAPI:message];
            if (unretainedSelf.didReceiveMessageBlock)
                unretainedSelf.didReceiveMessageBlock(message);
        }];

        // Initialize our regular API client.
        // TODO: Find a clean way to pass in the access token here. Save it to Core Data, most likely.
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:kIFBKUserDefaultAccessToken];
        _apiClient = [[IFBKCampfireClient alloc] initWithBaseURL:_user.launchpadAccount.hrefUrl accessToken:token];
    }
    return self;
}

#pragma mark - Properties

- (void)setDidReceiveMessageBlock:(void (^)(IFBKCFMessage *))didReceiveMessageBlock {
    _didReceiveMessageBlock = didReceiveMessageBlock;
    __weak IFBKRoomManager *unretainedSelf = self;
    [self.streamingClient setMessageReceivedBlock:^(IFBKCFMessage *message) {
        [unretainedSelf processMessageFromAPI:message];
        unretainedSelf.didReceiveMessageBlock(message);
    }];
}

#pragma mark - Public methods

- (void)loadRecentHistory:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    [self loadHistorySinceMessageId:nil success:success failure:failure];
}

- (void)loadHistorySinceMessageId:(NSNumber *)messageId
                          success:(void (^)(void))success
                          failure:(void (^)(NSError *))failure {
    [self.apiClient getMessagesForRoom:self.room.identifier sinceMessageId:messageId success:^(NSArray *result) {
        IFBKCFMessage *lastMessage = nil;
        for (IFBKCFMessage *message in result) {
            [self processMessageFromAPI:message];
            lastMessage = message;
        }
        DDLogAPI(@"Loaded %i messages from API.", [self.messages count]);
        if (self.didReceiveMessageBlock) self.didReceiveMessageBlock(lastMessage);
    } failure:^(NSError *error, NSInteger responseCode) {
        NSLog(@"Encountered error %i getting messages for room. Error: %@", responseCode, error);
    }];
}

- (void)startStreamingMessages {
    [self.streamingClient openConnectionWithSuccess:^{
        NSLog(@"Streaming connection opened.");
    } failure:^(NSError *error) {
        NSLog(@"Error! %@.", error);
    }];
}

- (void)stopStreamingMessages {
    [self.streamingClient closeConnection];
    NSLog(@"Streaming connection closed.");
}

#pragma mark - Private methods

- (void)processMessageFromAPI:(IFBKCFMessage *)message {
    if ([self.messages containsObject:message]) {
        [self.messages replaceObjectAtIndex:[self.messages indexOfObject:message] withObject:message];
    } else {
        [self.messages addObject:message];
    }
    //[self.messages sortUsingComparator:^NSComparisonResult(IFBKCFMessage *message1, IFBKCFMessage *message2) {
    //    return [message1.createdAt compare:message2.createdAt];
    //}];
}

@end
