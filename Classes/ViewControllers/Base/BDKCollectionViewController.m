#import "BDKCollectionViewController.h"

@interface BDKCollectionViewController ()

@end

@implementation BDKCollectionViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _collectionView = nil;
        _flowLayout = nil;
    }
}

#pragma mark - Properties

- (UICollectionView *)collectionView
{
    if (_collectionView) return _collectionView;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout) return _flowLayout;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    return _flowLayout;
}

@end