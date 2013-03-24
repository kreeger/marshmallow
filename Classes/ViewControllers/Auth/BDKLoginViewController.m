#import "BDKLoginViewController.h"
#import "BDKTextFieldCell.h"

@interface BDKLoginViewController ()

@end

@implementation BDKLoginViewController

- (id)init
{
    if (self = [super initWithIdentifier:@"login" tableViewStyle:UITableViewStyleGrouped]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parent overrides

- (void)registerCellTypes {
    [self.tableView registerClass:[BDKTextFieldCell class] forCellReuseIdentifier:kBDKTextFieldCellID];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDKTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:kBDKTextFieldCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Username";
    } else {
        cell.textLabel.text = @"Password";
    }

    return cell;
}

@end
