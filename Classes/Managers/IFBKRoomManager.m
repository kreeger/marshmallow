#import "IFBKRoomManager.h"

#import <BDKThirtySeven/BDKCampfireStreamingClient.h>
#import <BDKThirtySeven/BDKCampfireClient.h>
#import <BDKThirtySeven/BDKCFRoom.h>
#import <BDKThirtySeven/BDKCFMessage.h>

#import "IFBKUser.h"
#import "IFBKLaunchpadAccount.h"

@interface IFBKRoomManager ()

/** The streaming Campfire API for downloading messages in real-time.
 */
@property (strong, nonatomic) BDKCampfireStreamingClient *streamingClient;

/** The standard, non-streaming Campfire client.
 */
@property (strong, nonatomic) BDKCampfireClient *apiClient;

/** Initializes a version of this room manager with a given room and user.
 *
 *  @param room A Campfire room.
 *  @param user The user that has access to this room.
 *  @returns An instance of self.
 */
- (id)initWithRoom:(BDKCFRoom *)room user:(IFBKUser *)user;

/** Handles an incoming message from the Campfire API (and saves it).
 *  @param message The incoming message object.
 */
- (void)processMessageFromAPI:(BDKCFMessage *)message;

@end

@implementation IFBKRoomManager

@synthesize room = _room, user = _user;

+ (id)roomManagerWithRoom:(BDKCFRoom *)room user:(IFBKUser *)user {
    return [[self alloc] initWithRoom:room user:user];
}

- (id)initWithRoom:(BDKCFRoom *)room user:(IFBKUser *)user {
    if (self = [super init]) {
        _room = room;
        _user = user;
        _messages = [NSMutableArray array];

        // Initialize our streaming client.
        _streamingClient = [[BDKCampfireStreamingClient alloc] initWithRoomId:_room.identifier
                                                           authorizationToken:_user.apiAuthToken];
        __weak IFBKRoomManager *unretainedSelf = self;
        [_streamingClient setMessageReceivedBlock:^(BDKCFMessage *message) {
            [unretainedSelf processMessageFromAPI:message];
        }];

        // Initialize our regular API client.
        // TODO: Find a clean way to pass in the access token here. Save it to Core Data, most likely.
        _apiClient = [[BDKCampfireClient alloc] initWithBaseURL:_user.launchpadAccount.hrefUrl accessToken:nil];
    }
    return self;
}

#pragma mark - Public methods

- (void)loadRecentHistory:(void (^)(void))success failure:(void (^)(NSError *error))failure {
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

- (void)processMessageFromAPI:(BDKCFMessage *)message {
    NSLog(@"Room manager received message type %@, body %@.", message.type, message.body);

    // TODO: Should always make sure this is sorted by timestamp!
    [self.messages addObject:message];
}

@end
