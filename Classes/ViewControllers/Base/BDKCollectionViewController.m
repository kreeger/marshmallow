#import "BDKCollectionViewController.h"

@implementation BDKCollectionViewController

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    self.collectionView.frame = self.frame;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self.collectionView indexPathsForSelectedItems] each:^(NSIndexPath *path) {
        [self.collectionView deselectItemAtIndexPath:path animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _collectionView = nil;
        _flowLayout = nil;
    }
}

#pragma mark - Properties

- (UICollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
    _collectionView.opaque = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout) return _flowLayout;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    return _flowLayout;
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
