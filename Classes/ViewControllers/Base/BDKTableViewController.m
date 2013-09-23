#import "BDKTableViewController.h"

#import <Masonry/Masonry.h>

@interface BDKTableViewController ()

@end

@implementation BDKTableViewController

+ (instancetype)vcWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle {
    return [[self alloc] initWithIdentifier:identifier tableViewStyle:tableViewStyle];
}

- (instancetype)initWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle {
    if (self = [super initWithIdentifier:identifier]) {
        _tableViewStyle = tableViewStyle;
        self.pullToRefreshEnabled = NO;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.pullToRefreshEnabled) {
        [self.tableView addSubview:self.refreshControl];
    }
    
    [self registerCellTypes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties

- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return _tableView;
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
        if (!self.refreshControl.superview) {
            [self.tableView addSubview:self.refreshControl];
        }
    } else {
        if (self.refreshControl.superview) {
            [self.refreshControl removeFromSuperview];
        }
    }
}

#pragma mark - Methods

- (void)registerCellTypes {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)pullToRefreshPulled:(UIRefreshControl *)sender {
    // This space intentionally left blank.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    return [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // This space intentionally left blank.
}

@end
