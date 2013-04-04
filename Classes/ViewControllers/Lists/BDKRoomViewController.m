#import "BDKRoomViewController.h"
#import "BDKRoom.h"

@interface BDKRoomViewController ()

/** An initializer that takes a BDKRoom and sets everything up all nice.
 *  @param room The room to be displayed in this view controller.
 *  @returns An instance of self.
 */
- (id)initWithRoom:(BDKRoom *)room;

@end

@implementation BDKRoomViewController

@synthesize room = _room;

+ (id)vcWithRoom:(BDKRoom *)room
{
    return [[self alloc] initWithRoom:room];
}

- (id)initWithRoom:(BDKRoom *)room
{
    if (self = [super initWithIdentifier:room.name]) {
        _room = room;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.room.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
