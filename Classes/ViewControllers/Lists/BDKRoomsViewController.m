#import "BDKRoomsViewController.h"
#import "BDKRoomViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "BDKRoom.h"

#import "BDKRoomCollectionCell.h"

@interface BDKRoomsViewController ()

@property (strong, nonatomic) NSArray *rooms;

/** Loads up the necessary data into the collection view.
 */
- (void)performFetch;

/** Gets a BDKRoom given the index path.
 *  @param indexPath the index path to use when finding the room (the `row` property will be used).
 *  @returns A room object.
 */
- (BDKRoom *)roomForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BDKRoomsViewController

@synthesize flowLayout = _flowLayout;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[BDKRoomCollectionCell class]
            forCellWithReuseIdentifier:kBDKRoomCollectionCellId];
    
    self.title = @"Rooms";
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

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout) return _flowLayout;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(302, 44);
    _flowLayout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.minimumLineSpacing = 5;
    return _flowLayout;
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
