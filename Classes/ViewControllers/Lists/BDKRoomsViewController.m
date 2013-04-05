#import "BDKRoomsViewController.h"
#import "BDKRoomViewController.h"
#import "BDKUserViewController.h"

#import "UINavigationController+BDKKit.h"

#import <QuartzCore/QuartzCore.h>

#import "BDKRoom.h"

#import "BDKRoomCollectionCell.h"

@interface BDKRoomsViewController ()

@property (strong, nonatomic) NSArray *rooms;
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

@synthesize flowLayout = _flowLayout;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[BDKRoomCollectionCell class]
            forCellWithReuseIdentifier:kBDKRoomCollectionCellId];
    
    self.title = @"Rooms";
    self.navigationItem.leftBarButtonItem = self.profileBarButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(performFetch)
                                                 name:kBDKNotificationDidFinishChangingAccount object:nil];
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
}

#pragma mark - Properties

- (UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout) return _flowLayout;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(302, 44);
    _flowLayout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.minimumLineSpacing = 5;
    return _flowLayout;
}

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
    self.rooms = [BDKRoom findAll];
}

- (BDKRoom *)roomForIndexPath:(NSIndexPath *)indexPath
{
    return self.rooms[indexPath.row];
}

- (void)profileBarButtonTapped:(UIBarButtonItem *)sender
{
    [self presentProfileController];
}

- (void)presentProfileController
{
    BDKUserViewController *userVC = [BDKUserViewController vcWithBDKUser:self.currentUser];
    userVC.modalDismissalBlock = ^{ [self dismissViewControllerAnimated:YES completion:nil]; };
    UINavigationController *nav = [UINavigationController controllerWithRootViewController:userVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.rooms count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDKRoomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBDKRoomCollectionCellId
                                                                           forIndexPath:indexPath];
    BDKRoom *room = [self roomForIndexPath:indexPath];
    cell.label.text = room.name;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDKRoomViewController *roomVC = [BDKRoomViewController vcWithRoom:[self roomForIndexPath:indexPath]];
    [self.navigationController pushViewController:roomVC animated:YES];
}
@end
