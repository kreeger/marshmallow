#import "BDKRoomsViewController.h"
#import "BDKRoomViewController.h"
#import "BDKUserViewController.h"

#import "UINavigationController+BDKKit.h"

#import <QuartzCore/QuartzCore.h>

#import "BDKRoom.h"

#import "BDKRoomCollectionCell.h"

@interface BDKRoomsViewController ()

@property (strong, nonatomic) NSFetchedResultsController *resultsController;
@property (strong, nonatomic) UIBarButtonItem *profileBarButton;

/** Loads up the necessary data into the collection view.
 */
- (void)performFetch;

/** Gets a BDKRoom given the index path.
 *  @param indexPath the index path to use when finding the room (the `row` property will be used).
 *  @returns A room object.
 */
- (BDKRoom *)roomForIndexPath:(NSIndexPath *)indexPath;

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
                                                 name:kBDKNotificationDidFinishChangingAccount object:nil];
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
        self.resultsController = nil;
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

- (NSFetchedResultsController *)resultsController
{
    if (_resultsController) return _resultsController;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"BDKRoom"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    request.fetchBatchSize = 30;
    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                             managedObjectContext:[NSManagedObjectContext defaultContext]
                                                               sectionNameKeyPath:@"account.name"
                                                                        cacheName:nil];
    return _resultsController;
}

#pragma mark - Methods

- (void)performFetch
{
    [self.resultsController performFetch:nil];
    [self.tableView reloadData];
}

- (BDKRoom *)roomForIndexPath:(NSIndexPath *)indexPath
{
    return [self.resultsController objectAtIndexPath:indexPath];
}

- (void)profileBarButtonTapped:(UIBarButtonItem *)sender
{
    [self presentProfileController];
}

- (void)presentProfileController
{
    BDKUserViewController *userVC = [BDKUserViewController vcWithBDKUser:self.currentUser];
    userVC.modalDismissalBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [UINavigationController controllerWithRootViewController:userVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.resultsController.sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.resultsController.sections[section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenericCell" forIndexPath:indexPath];
    BDKRoom *room = [self roomForIndexPath:indexPath];
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
