#import "BDKScrollViewController.h"

#import <Masonry/Masonry.h>

@interface BDKScrollViewController ()

@end

@implementation BDKScrollViewController

@synthesize scrollView = _scrollView;

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Properties

- (UIScrollView *)scrollView {
    if (_scrollView) return _scrollView;
    _scrollView = [UIScrollView new];
    [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _scrollView.delegate = self;
    return _scrollView;
}

@end
