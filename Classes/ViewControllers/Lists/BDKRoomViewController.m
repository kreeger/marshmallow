#import "BDKRoomViewController.h"

#import "BDKRoomCollectionCell.h"

#import "BDKCampfireClient.h"
#import "BDKCFRoom.h"
#import "IFBKRoom.h"
#import "BDKCFMessage.h"

@interface BDKRoomViewController ()

/** An initializer that takes a IFBKRoom and sets everything up all nice.
 *  @param room The room to be displayed in this view controller.
 *  @returns An instance of self.
 */
- (id)initWithRoom:(IFBKRoom *)room;

/** Gets the message associated with a given index path.
 *  @param indexPath The index path for which to retrieve the message.
 *  @returns A message.
 */
- (BDKCFMessage *)messageForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BDKRoomViewController

+ (id)vcWithRoom:(IFBKRoom *)room
{
    return [[self alloc] initWithRoom:room];
}

- (id)initWithRoom:(IFBKRoom *)room
{
    if (self = [super initWithIdentifier:room.name]) {
        _room = room;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
    
    self.title = self.room.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSMutableArray *messageIds = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods

- (BDKCFMessage *)messageForIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    BDKCFMessage *message = [self messageForIndexPath:indexPath];
    cell.textLabel.text = message.body;
    cell.textLabel.font = [UIFont appFontOfSize:12];
    return cell;
}

#pragma mark - UITableViewDelegate

@end
