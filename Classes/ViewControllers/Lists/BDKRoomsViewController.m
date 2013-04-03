#import "BDKRoomsViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "BDKRoom.h"

#import "BDKRoomCollectionCell.h"

@interface BDKRoomsViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *resultsController;
@property (strong, nonatomic) NSMutableArray *objectChanges;
@property (strong, nonatomic) NSMutableArray *sectionChanges;

- (void)performFetch;

@end

@implementation BDKRoomsViewController

@synthesize flowLayout = _flowLayout;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.objectChanges = [NSMutableArray array];
    self.sectionChanges = [NSMutableArray array];

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

- (NSFetchedResultsController *)resultsController
{
    if (_resultsController) return _resultsController;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BDKRoom"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                             managedObjectContext:[NSManagedObjectContext defaultContext]
                                                               sectionNameKeyPath:nil
                                                                        cacheName:@"rooms"];
    return _resultsController;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout) return _flowLayout;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(300, 44);
    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _flowLayout.minimumInteritemSpacing = 10;
    _flowLayout.minimumLineSpacing = 10;
    return _flowLayout;
}

#pragma mark - Methods

- (void)performFetch
{
    NSError *error = nil;
    BOOL success = [self.resultsController performFetch:&error];
    if (!success) DDLogError(@"Encountered fetch error: %@, %@.", error, [error userInfo]);
    [self.collectionView reloadData];
    DDLogUI(@"Fetched with %i objects.", [self.resultsController.sections[0] numberOfObjects]);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.resultsController.sections[section] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBDKRoomCollectionCellId
                                                                           forIndexPath:indexPath];
    BDKRoom *room = (BDKRoom *)[self.resultsController objectAtIndexPath:indexPath];
    ((BDKRoomCollectionCell *)cell).label.text = room.name;
    DDLogUI(@"Rendering cell %@.", room.name);
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.resultsController.sections.count;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSString *)controller:(NSFetchedResultsController *)controller
    sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return sectionName;
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    NSMutableDictionary *change = [NSMutableDictionary dictionary];
    NSNumber *index = @(type);
    switch (type) {
        case NSFetchedResultsChangeInsert:
            change[index] = @[@(sectionIndex)];
            break;
        case NSFetchedResultsChangeDelete:
            change[index] = @[@(sectionIndex)];
            break;
        case NSFetchedResultsChangeMove: break;
        case NSFetchedResultsChangeUpdate: break;
    }
    [self.sectionChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSMutableDictionary *change = [NSMutableDictionary dictionary];
    NSNumber *index = @(type);
    switch (type) {
        case NSFetchedResultsChangeInsert:
            change[index] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[index] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[index] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[index] = @[indexPath, newIndexPath];
            break;
    }
    [self.objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // I'd like to thank the academy, and also https://github.com/AshFurrow/UICollectionView-NSFetchedResultsController
    if (self.sectionChanges.count > 0) {
        [self.collectionView performBatchUpdates:^{
            [self.sectionChanges each:^(NSDictionary *change) {
                [change each:^(NSNumber *key, id obj) {
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]];
                    switch (type) {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertSections:indexSet];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteSections:indexSet];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadSections:indexSet];
                            break;
                        case NSFetchedResultsChangeMove:break;
                    }
                }];
            }];
        } completion:nil];
    }

    if (self.objectChanges.count > 0 && self.sectionChanges.count == 0) {
        [self.collectionView performBatchUpdates:^{
            [self.objectChanges each:^(NSDictionary *change) {
                [change each:^(NSNumber *key, id obj) {
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type) {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertItemsAtIndexPaths:@[obj]];
                            break;
                        case NSFetchedResultsChangeDelete:
                            [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                            break;
                        case NSFetchedResultsChangeUpdate:
                            [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                            break;
                        case NSFetchedResultsChangeMove:
                            [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                    }
                }];
            }];
        } completion:nil];
    }

    [self.sectionChanges removeAllObjects];
    [self.objectChanges removeAllObjects];
}

@end
