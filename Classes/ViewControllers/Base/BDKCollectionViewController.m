#import "BDKCollectionViewController.h"

#import <Masonry/Masonry.h>
#import <BDKKit/NSArray+BDKKit.h>

@implementation BDKCollectionViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pullToRefreshEnabled = NO;
    [self registerCellTypes];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self.collectionView indexPathsForSelectedItems] each:^(NSIndexPath *path) {
        [self.collectionView deselectItemAtIndexPath:path animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (!self.view.superview) {
        _collectionView = nil;
        _flowLayout = nil;
    }
}

#pragma mark - Properties

- (UICollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    _collectionView.opaque = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout) return _flowLayout;
    _flowLayout = [UICollectionViewFlowLayout new];
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.minimumLineSpacing = 0;
    return _flowLayout;
}

- (UIRefreshControl *)refreshControl {
    if (_refreshControl) return _refreshControl;
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(pullToRefreshPulled:) forControlEvents:UIControlEventValueChanged];
    return _refreshControl;
}

- (void)setPullToRefreshEnabled:(BOOL)pullToRefreshEnabled {
    if (pullToRefreshEnabled == _pullToRefreshEnabled) return;
    if (pullToRefreshEnabled) {
        if (!self.refreshControl.superview) [self.collectionView addSubview:self.refreshControl];
    } else {
        if (self.refreshControl.superview) [self.refreshControl removeFromSuperview];
    }
}

#pragma mark - Methods

- (void)registerCellTypes {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)pullToRefreshPulled:(UIRefreshControl *)sender {
    // This space intentionally left blank.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // This space intentionally left blank.
}

@end
