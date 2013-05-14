#import "BDKRoomViewController.h"

#import "BDKMessageCell.h"

#import "BDKCampfireClient.h"
#import "IFBKRoomManager.h"

#import "BDKCFRoom.h"
#import "BDKCFMessage.h"

@interface BDKRoomViewController ()

/** An initializer that takes a IFBKRoomManager and sets everything up all nice.
 *  @param roomManager The room manager to be userd in this view controller.
 *  @returns An instance of self.
 */
- (id)initWithRoomManager:(IFBKRoomManager *)roomManager;

/** Gets the message associated with a given index path.
 *  @param indexPath The index path for which to retrieve the message.
 *  @returns A message.
 */
- (BDKCFMessage *)messageForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BDKRoomViewController

@synthesize roomManager = _roomManager;

+ (id)vcWithRoomManager:(IFBKRoomManager *)roomManager {
    return [[self alloc] initWithRoomManager:roomManager];
}

- (id)initWithRoomManager:(IFBKRoomManager *)roomManager {
    if (self = [super initWithIdentifier:roomManager.room.name]) {
        _roomManager = roomManager;
        __weak BDKRoomViewController *unretainedSelf = self;
        _roomManager.didReceiveMessageBlock = ^(BDKCFMessage *message) {
            [unretainedSelf.tableView reloadData];
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.roomManager.room.name;
}

- (void)registerCellTypes {
    [self.tableView registerClass:[BDKMessageCell class] forCellReuseIdentifier:kBDKMessageCellID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.roomManager loadRecentHistory:^{
        //
    } failure:^(NSError *error) {
        // pass for now
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.roomManager startStreamingMessages];
//    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.roomManager stopStreamingMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Methods

- (BDKCFMessage *)messageForIndexPath:(NSIndexPath *)indexPath {
    BDKCFMessage *message = [self.roomManager.messages objectAtIndex:indexPath.row];
    return message;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.roomManager.messages count];
}

- (BDKMessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kBDKMessageCellID forIndexPath:indexPath];
    BDKCFMessage *message = [self messageForIndexPath:indexPath];
    DDLogUI(@"Setting message %@ // %@ for index path %@.", message.identifier, message.body, indexPath);
    cell.message = message;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UITableViewDelegate

@end
