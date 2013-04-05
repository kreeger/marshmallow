#import "BDKUserViewController.h"
#import "BDKUser.h"

@interface BDKUserViewController ()

/** Initializes the view controller for a user.
 *  @param user The user with which to initialize this view controller.
 *  @returns An instance of self.
 */
- (id)initWithBDKUser:(BDKUser *)user;

@end

@implementation BDKUserViewController

@synthesize user = _user;

+ (id)vcWithBDKUser:(BDKUser *)user
{
    return [[self alloc] initWithBDKUser:user];
}

- (id)initWithBDKUser:(BDKUser *)user
{
    if (self = [super initWithIdentifier:NSStringWithFormat(@"user:%@", user.name)]) {
        _user = user;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.user.identifier isEqualToNumber:self.currentUserId] ? @"Me" : self.user.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
