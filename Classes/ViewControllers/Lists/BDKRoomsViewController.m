#import "BDKRoomsViewController.h"
#import "BDKRoomViewController.h"
#import "BDKUserViewController.h"
#import "BDKAppDelegate.h"
#import "IFBKAccountsManager.h"
#import "UINavigationController+BDKKit.h"

#import "IFBKRoom.h"

#import "BDKRoomCollectionCell.h"

@interface BDKRoomsViewController ()

@property (weak, nonatomic) NSArray *rooms;
@property (strong, nonatomic) UIBarButtonItem *profileBarButton;

/** Loads up the necessary data into the collection view.
 */
- (void)performFetch;

/** Gets an IFBKRoom given the index path.
 *  @param indexPath the index path to use when finding the room (the `row` property will be used).
 *  @returns A room object.
 */
- (IFBKRoom *)roomForIndexPath:(NSIndexPath *)indexPath;

/** Fired when the profile button is tapped.
 *  @param sender The sender of the event.
 */
- (void)profileBarButtonTapped:(UIBarButtonItem *)sender;

/** Loads the profile controller.
 */
- (void)presentProfileController;

@end

@implementation BDKRoomsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GenericCell"];
    
    self.title = @"Rooms";
    self.navigationItem.leftBarButtonItem = self.profileBarButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performFetch)
                                                 name:kBDKNotificationDidReloadRooms object:nil];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self performFetch];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _rooms = nil;
    }
}

#pragma mark - Properties

- (UIBarButtonItem *)profileBarButton
{
    if (_profileBarButton) return _profileBarButton;
    _profileBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self action:@selector(profileBarButtonTapped:)];
    return _profileBarButton;
}

#pragma mark - Methods

- (void)performFetch
{
    self.rooms = ((BDKAppDelegate *)[[UIApplication sharedApplication] delegate]).accountsManager.rooms;
    [self.tableView reloadData];
}

- (IFBKRoom *)roomForIndexPath:(NSIndexPath *)indexPath
{
    return self.rooms[indexPath.section][@"rooms"][indexPath.row];
}

- (void)profileBarButtonTapped:(UIBarButtonItem *)sender
{
    [self presentProfileController];
}

- (void)presentProfileController
{
    BDKUserViewController *userVC = [BDKUserViewController vcWithIFBKUser:self.currentUser];
    userVC.modalDismissalBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [UINavigationController controllerWithRootViewController:userVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.rooms count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.rooms[section][@"title"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rooms[section][@"rooms"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    IFBKRoom *room = [self roomForIndexPath:indexPath];
    cell.textLabel.text = room.name;
    cell.textLabel.font = [UIFont boldAppFontOfSize:18];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDKRoomViewController *roomVC = [BDKRoomViewController vcWithRoom:[self roomForIndexPath:indexPath]];
    [self.navigationController pushViewController:roomVC animated:YES];
}

@end
