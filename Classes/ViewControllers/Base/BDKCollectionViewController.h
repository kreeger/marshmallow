#import "BDKViewController.h"

/**
 A handy wrapper around a collection view.
 */
@interface BDKCollectionViewController : BDKViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL pullToRefreshEnabled;

/**
 Registers cell types with the table view.
 */
- (void)registerCellTypes;

/**
 Fired when the pull-to-refresh control has been triggered.
 
 @param sender The sender of the pull-to-refresh event.
 */
- (void)pullToRefreshPulled:(UIRefreshControl *)sender;

@end
