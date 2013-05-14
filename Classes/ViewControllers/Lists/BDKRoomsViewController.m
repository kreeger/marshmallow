#import "BDKRoomsViewController.h"
#import "BDKRoomViewController.h"
#import "BDKUserViewController.h"
#import "BDKAppDelegate.h"

#import "IFBKAccountsManager.h"
#import "IFBKRoomManager.h"

#import "BDKCFRoom.h"
#import "IFBKAccount.h"

#import "BDKRoomCollectionCell.h"
#import "BDKTableHeaderView.h"

#import "UINavigationController+BDKKit.h"

@interface BDKRoomsViewController ()

@property (weak, nonatomic) NSArray *rooms;
@property (strong, nonatomic) UIBarButtonItem *profileBarButton;

/** Loads up the necessary data into the collection view.
 */
- (void)performFetch;

/** Gets an BDKCFRoom given the index path.
 *  @param indexPath the index path to use when finding the room (the `row` property will be used).
 *  @returns A room object.
 */
- (BDKCFRoom *)roomForIndexPath:(NSIndexPath *)indexPath;

/** Gets an IFBKAccount given the index path.
 *  @param indexPath the index path to use when finding the account (the `section` property will be used).
 *  @returns An account object.
 */
- (IFBKAccount *)accountForIndexPath:(NSIndexPath *)indexPath;

/** Fired when the profile button is tapped.
 *  @param sender The sender of the event.
 */
- (void)profileBarButtonTapped:(UIBarButtonItem *)sender;

/** Loads the profile controller.
 */
- (void)presentProfileController;

@end

@implementation BDKRoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullToRefreshEnabled = YES;
    self.title = @"Rooms";
    self.navigationItem.leftBarButtonItem = self.profileBarButton;
    [self.refreshControl beginRefreshing];
}

- (void)registerCellTypes {
    [super registerCellTypes];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performFetch)
                                                 name:kBDKNotificationDidReloadRooms object:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self performFetch];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _rooms = nil;
    }
}

#pragma mark - Properties

- (UIBarButtonItem *)profileBarButton {
    if (_profileBarButton) return _profileBarButton;
    _profileBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self action:@selector(profileBarButtonTapped:)];
    return _profileBarButton;
}

#pragma mark - Methods

- (void)pullToRefreshPulled:(UIRefreshControl *)sender {
    DDLogUI(@"Refresh pulled.");
    [((BDKAppDelegate *)[[UIApplication sharedApplication] delegate]).accountsManager getRooms:^(NSArray *rooms) {
        [self performFetch];
    } failure:^(NSError *error) {
        DDLogError(@"Failure getting rooms on pull-to-refresh. %@", error);
    }];
}

- (void)performFetch {
    self.rooms = ((BDKAppDelegate *)[[UIApplication sharedApplication] delegate]).accountsManager.rooms;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (BDKCFRoom *)roomForIndexPath:(NSIndexPath *)indexPath {
    return self.rooms[indexPath.section][@"rooms"][indexPath.row];
}

- (IFBKAccount *)accountForIndexPath:(NSIndexPath *)indexPath {
    return self.rooms[indexPath.section][@"account"];
}

- (void)profileBarButtonTapped:(UIBarButtonItem *)sender {
    [self presentProfileController];
}

- (void)presentProfileController {
    BDKUserViewController *userVC = [BDKUserViewController vcWithIFBKUser:nil];
    userVC.modalDismissalBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [UINavigationController controllerWithRootViewController:userVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.rooms count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return ((IFBKAccount *)self.rooms[section][@"account"]).name;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = ((IFBKAccount *)self.rooms[section][@"account"]).name;
    return [BDKTableHeaderView headerWithTitle:title width:self.tableView.frameHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rooms[section][@"rooms"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    BDKCFRoom *room = [self roomForIndexPath:indexPath];
    cell.textLabel.text = room.name;
    cell.textLabel.font = [UIFont boldAppFontOfSize:18];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BDKCFRoom *room = [self roomForIndexPath:indexPath];
    IFBKAccount *account = [self accountForIndexPath:indexPath];
    IFBKRoomManager *roomManager = [IFBKRoomManager roomManagerWithRoom:room user:account.user];
    BDKRoomViewController *roomVC = [BDKRoomViewController vcWithRoomManager:roomManager];
    [self.navigationController pushViewController:roomVC animated:YES];
}

@end
