#import "BDKRoomViewController.h"

#import "BDKMessageCell.h"
#import "BDKTableHeaderView.h"

#import "IFBKRoomManager.h"

#import <IFBKThirtySeven/IFBKCampfireClient.h>

#import "IFBKCFRoom.h"
#import "IFBKCFMessage.h"
#import "IFBKUser.h"

@interface BDKRoomViewController ()

/** An initializer that takes a IFBKRoomManager and sets everything up all nice.
 *  @param roomManager The room manager to be userd in this view controller.
 *  @returns An instance of self.
 */
- (id)initWithRoomManager:(IFBKRoomManager *)roomManager;

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
        _roomManager.didReceiveMessageBlock = ^(IFBKCFMessage *message) {
            [unretainedSelf.tableView reloadData];
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = self.roomManager.room.name;
}

- (void)registerCellTypes {
    [self.tableView registerClass:[BDKMessageCell class] forCellReuseIdentifier:kBDKMessageCellID];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.roomManager loadRoomAndHistory:^{
        //
    } failure:^(NSError *error) {
        // pass for now
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // TODO: Don't join if room is already "joined" to.
    [self.roomManager joinRoom:^{
        DDLogAPI(@"Room joined.");
    } failure:^(NSError *error) {
        DDLogWarn(@"Failed to join room. %@.", error);
    }];
    
    [self.roomManager startStreamingMessages:^{
        DDLogAPI(@"Began streaming.");
    } failure:^(NSError *error) {
        DDLogWarn(@"Could not start streaming. %@", error.localizedDescription);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.roomManager stopStreamingMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.roomManager numberOfMessageSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.roomManager messagesForSection:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.roomManager userForSection:section] name];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = [[self.roomManager userForSection:section] name];
    title = title ? title : @"System";
    return [BDKTableHeaderView headerWithTitle:title width:self.tableView.frameHeight];
}

- (BDKMessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDKMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kBDKMessageCellID forIndexPath:indexPath];
    cell.message = [self.roomManager messageAtIndexPath:indexPath];
    cell.backPosition = BDKMessageCellPositionTop;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark - UITableViewDelegate

@end
