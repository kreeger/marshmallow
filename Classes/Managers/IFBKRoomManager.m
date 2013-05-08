#import "IFBKRoomManager.h"

#import "BDKCFRoom.h"

@interface IFBKRoomManager ()

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
    }
    return self;
}

@end
