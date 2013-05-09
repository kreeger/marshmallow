#import "IFBKRoomManager.h"

#import "BDKCampfireStreamingClient.h"

#import "BDKCFRoom.h"
#import "IFBKUser.h"

@interface IFBKRoomManager ()

@property (strong, nonatomic) BDKCampfireStreamingClient *streamingClient;

/** Initializes a version of this room manager with a given room and user.
 *
 *  @param room A Campfire room.
 *  @param user The user that has access to this room.
 *  @returns An instance of self.
 */
- (id)initWithRoom:(BDKCFRoom *)room user:(IFBKUser *)user;

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
        _streamingClient = [[BDKCampfireStreamingClient alloc] initWithRoomId:_room.identifier
                                                           authorizationToken:_user.apiAuthToken];
    }
    return self;
}

#pragma mark - Public methods

- (void)startStreamingMessages {
    
}

@end
