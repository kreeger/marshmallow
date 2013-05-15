#import "BDKUserViewController.h"

#import "IFBKUser.h"

@interface BDKUserViewController ()

/** Initializes the view controller for a user facade.
 *  @param user The user with which to initialize this view controller.
 *  @returns An instance of self.
 */
- (id)initWithUser:(IFBKUser *)user;

@end

@implementation BDKUserViewController

@synthesize user = _user;

+ (id)vcWithUser:(IFBKUser *)user {
    return [[self alloc] initWithUser:user];
}

- (id)initWithUser:(IFBKUser *)user {
    if (self = [super initWithIdentifier:NSStringWithFormat(@"user:%@", user.name)]) {
        _user = user;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.user.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
