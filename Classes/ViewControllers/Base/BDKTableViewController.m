#import "BDKTableViewController.h"

@interface BDKTableViewController ()

@end

@implementation BDKTableViewController

+ (id)vcWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle
{
    return [[self alloc] initWithIdentifier:identifier tableViewStyle:tableViewStyle];
}

- (id)initWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle
{
    if (self = [super initWithIdentifier:identifier]) {
        _tableViewStyle = tableViewStyle;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerCellTypes];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UITableView *)tableView
{
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:self.tableViewStyle];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}

#pragma mark - Methods

- (void)registerCellTypes {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    return [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Pass.
}

@end
