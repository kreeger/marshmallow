#import "BDKRoomViewController.h"

#import "BDKRoomCollectionCell.h"

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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.roomManager.room.name;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.roomManager loadRecentHistory:^{
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        // pass for now
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.roomManager startStreamingMessages];
    [self.tableView reloadData];
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
    return self.roomManager.messages[indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.roomManager.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    BDKCFMessage *message = [self messageForIndexPath:indexPath];
    if (![(NSNull *)message.body isEqual:[NSNull null]]) {
        cell.textLabel.text = message.body;
        cell.textLabel.font = [UIFont appFontOfSize:12];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

@end
