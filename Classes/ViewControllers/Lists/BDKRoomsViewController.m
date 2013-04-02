#import "BDKRoomsViewController.h"

@interface BDKRoomsViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSMutableArray *objectChanges;
@property (strong, nonatomic) NSMutableArray *sectionChanges;

@end

@implementation BDKRoomsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Rooms";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
