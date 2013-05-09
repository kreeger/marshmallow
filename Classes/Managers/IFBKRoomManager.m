#import "IFBKRoomManager.h"

#import "BDKCampfireStreamingClient.h"

#import "BDKCFRoom.h"

@interface IFBKRoomManager ()

@property (strong, nonatomic) BDKCampfireStreamingClient *streamingClient;

/** Initializes a version of this room manager with a given room.
 *
 *  @param room A Campfire room.
 *  @returns An instance of self.
 */
- (id)initWithRoom:(BDKCFRoom *)room;

@end

@implementation IFBKRoomManager

@synthesize room = _room;

+ (id)roomManagerWithRoom:(BDKCFRoom *)room {
    return [[self alloc] initWithRoom:room];
}

- (id)initWithRoom:(BDKCFRoom *)room {
    if (self = [super init]) {
        _room = room;
        _streamingClient = [[BDKCampfireStreamingClient alloc] initWithRoomId:_room.identifier
                                                           authorizationToken:nil];
    }
    return self;
}

#pragma mark - Public methods

- (void)startStreamingMessages {
    
}

@end
