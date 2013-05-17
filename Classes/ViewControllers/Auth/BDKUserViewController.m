#import "BDKUserViewController.h"

#import "IFBKUser.h"
#import "BDKUserPlacard.h"

@interface BDKUserViewController ()

/** The user's "37signals placard" view.
 */
@property (strong, nonatomic) BDKUserPlacard *placardView;

/** The cancel button.
 */
@property (strong, nonatomic) UIBarButtonItem *cancelButton;

/** Initializes the view controller for a user facade.
 *  @param user The user with which to initialize this view controller.
 *  @returns An instance of self.
 */
- (id)initWithIFBKUser:(IFBKUser *)user;

/** Fired when a user taps the cancel button.
 *  @param sender The sender of the event.
 */
- (void)cancelButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation BDKUserViewController

@synthesize user = _user;

+ (id)vcWithIFBKUser:(IFBKUser *)user {
    return [[self alloc] initWithIFBKUser:user];
}

- (id)initWithIFBKUser:(IFBKUser *)user {
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

- (void)viewWillAppear:(BOOL)animated {
    [self.view addSubview:self.placardView];
    self.navigationItem.leftBarButtonItem = self.cancelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties

- (BDKUserPlacard *)placardView {
    if (_placardView) return _placardView;
    _placardView = [[BDKUserPlacard alloc] initWithFrame:CGRectMake(0, 0, 320, 116)];
    [_placardView setUser:self.user];
    return _placardView;
}

- (UIBarButtonItem *)cancelButton {
    if (_cancelButton) return _cancelButton;
    _cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonTapped:)];
    return _cancelButton;
}

#pragma mark - Actions

- (void)cancelButtonTapped:(UIBarButtonItem *)sender {
    if (self.modalDismissalBlock) self.modalDismissalBlock();
    self.modalDismissalBlock = nil;
}

@end
