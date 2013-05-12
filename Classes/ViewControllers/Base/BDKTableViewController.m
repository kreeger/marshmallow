#import "BDKTableViewController.h"

@interface BDKTableViewController ()

@end

@implementation BDKTableViewController

+ (id)vcWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle {
    return [[self alloc] initWithIdentifier:identifier tableViewStyle:tableViewStyle];
}

- (id)initWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle {
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addSubview:self.refreshControl];
    [self registerCellTypes];
	// Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:self.tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}

- (UIRefreshControl *)refreshControl {
    if (_refreshControl) return _refreshControl;
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(pullToRefreshPulled:) forControlEvents:UIControlEventValueChanged];
    return _refreshControl;
}

- (void)setPullToRefreshEnabled:(BOOL)pullToRefreshEnabled {
    if (pullToRefreshEnabled == _pullToRefreshEnabled) return;
    if (pullToRefreshEnabled) {
        if (!self.refreshControl.superview) [self.tableView addSubview:self.refreshControl];
    } else {
        if (self.refreshControl.superview) [self.refreshControl removeFromSuperview];
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
