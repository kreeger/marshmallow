#import "BDKRoomsViewController.h"
#import "BDKRoomViewController.h"
#import "BDKUserViewController.h"
#import "BDKAppDelegate.h"

#import "MLLWCoreDataStore.h"
#import "MLLWAccountManager.h"
#import "MLLWRoomManager.h"
#import "BDKConstants.h"

#import "IFBKCFRoom.h"
#import "MLLWModels.h"

#import "BDKRoomCollectionCell.h"
#import "BDKTableHeaderView.h"

#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/UINavigationController+BDKKit.h>

#import "UIFont+App.h"

@interface BDKRoomsViewController ()

/**
 A reference to the rooms presented by this view controller.
 */
@property (weak, nonatomic) NSArray *rooms;

/**
 The toolbar button presenting the current user's profile.
 */
@property (strong, nonatomic) UIBarButtonItem *profileBarButton;

/**
 Gets an IFBKCFRoom given the index path.
 
 @param indexPath the index path to use when finding the room (the `row` property will be used).
 @return A room object.
 */
- (IFBKCFRoom *)roomForIndexPath:(NSIndexPath *)indexPath;

/**
 Gets an IFBKAccount given the index path.
 
 @param indexPath the index path to use when finding the account (the `section` property will be used).
 @return An account object.
 */
- (MLLWAccount *)accountForIndexPath:(NSIndexPath *)indexPath;

/**
 Fired when the profile button is tapped.
 
 @param sender The sender of the event.
 */
- (void)profileBarButtonTapped:(UIBarButtonItem *)sender;

/**
 Loads the profile controller.
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
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self refreshRooms];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (!self.view.superview) {
        _rooms = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark - Properties

- (UIBarButtonItem *)profileBarButton {
    if (_profileBarButton) return _profileBarButton;
    _profileBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self action:@selector(profileBarButtonTapped:)];
    _profileBarButton.enabled = NO;
    return _profileBarButton;
}

#pragma mark - Methods

- (void)pullToRefreshPulled:(UIRefreshControl *)sender {
    DDLogUI(@"Refresh pulled.");
    [self.accountManager getRooms:^(NSArray *rooms) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self refreshRooms];
        });
    } failure:^(NSError *error) {
        DDLogError(@"Failure getting rooms on pull-to-refresh. %@", error);
    }];
}

- (void)refreshRooms {
    self.rooms = self.accountManager.rooms;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)enableProfileButton:(BOOL)flag {
    self.profileBarButton.enabled = flag;
}

#pragma mark - Private methods

- (IFBKCFRoom *)roomForIndexPath:(NSIndexPath *)indexPath {
    return self.rooms[indexPath.section][@"rooms"][indexPath.row];
}

- (MLLWAccount *)accountForIndexPath:(NSIndexPath *)indexPath {
    NSNumber *identifier = self.rooms[indexPath.section][@"identifier"];
    MLLWLaunchpadAccount *account = [MLLWLaunchpadAccount findByIdentifier:identifier
                                                                 inContext:[NSManagedObjectContext defaultContext]];
    return [account campfireAccount];
}

- (void)profileBarButtonTapped:(UIBarButtonItem *)sender {
    [self presentProfileController];
}

- (void)presentProfileController {
    // Possibly store the user key in NSUserDefaults instead of this noodly crap.
    MLLWUser *user = [[MLLWUser findWithPredicate:[NSPredicate predicateWithFormat:@"launchpadAccount != nil"]] firstObject];
    BDKUserViewController *userVC = [BDKUserViewController vcWithIFBKUser:user];
    userVC.modalDismissalBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    userVC.userTappedLogoutBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
        [(BDKAppDelegate *)[[UIApplication sharedApplication] delegate] signoutCurrentUser];
    };
    UINavigationController *nav = [UINavigationController controllerWithRootViewController:userVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.rooms count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MLLWAccount *account = [self accountForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    return account.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rooms[section][@"rooms"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    IFBKCFRoom *room = [self roomForIndexPath:indexPath];
    cell.textLabel.text = room.name;
    cell.textLabel.font = [UIFont boldAppFontOfSize:18];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IFBKCFRoom *room = [self roomForIndexPath:indexPath];
    MLLWAccount *account = [self accountForIndexPath:indexPath];
    MLLWRoomManager *roomManager = [MLLWRoomManager roomManagerWithRoom:room user:account.user];
    BDKRoomViewController *roomVC = [BDKRoomViewController vcWithRoomManager:roomManager];
    [self.navigationController pushViewController:roomVC animated:YES];
}

@end
