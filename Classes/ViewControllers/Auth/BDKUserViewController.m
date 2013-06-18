#import "BDKUserViewController.h"

#import "IFBKUser.h"
#import "BDKUserPlacard.h"

#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/UIView+BDKKit.h>

@interface BDKUserViewController ()

/** The user's "37signals placard" view.
 */
@property (strong, nonatomic) BDKUserPlacard *placardView;

/** The cancel button.
 */
@property (strong, nonatomic) UIBarButtonItem *cancelButton;

/** The logout button.
 */
@property (strong, nonatomic) UIBarButtonItem *logoutButton;

/** Initializes the view controller for a user facade.
 *  @param user The user with which to initialize this view controller.
 *  @returns An instance of self.
 */
- (id)initWithIFBKUser:(IFBKUser *)user;

/** Fired when a user taps the cancel button.
 *  @param sender The sender of the event.
 */
- (void)cancelButtonTapped:(UIBarButtonItem *)sender;

/** Fired when a user taps the logout button.
 *  @param sender The sender of the event.
 */
- (void)logoutButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation BDKUserViewController

@synthesize user = _user;

+ (id)vcWithIFBKUser:(IFBKUser *)user {
    return [[self alloc] initWithIFBKUser:user];
}

- (id)initWithIFBKUser:(IFBKUser *)user {
    if (self = [super initWithIdentifier:[NSString stringWithFormat:@"user:%@", user.name]]) {
        _user = user;
        self.edgesForExtendedLayout = UIExtendedEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.placardView];
    self.title = self.user.name;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    NSDictionary *views = @{@"placardView": self.placardView};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[placardView]" options:0 metrics:nil views:views];
    NSArray *moreConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[placardView]|" options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
    [self.view addConstraints:moreConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    self.navigationItem.rightBarButtonItem = self.logoutButton;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties

- (BDKUserPlacard *)placardView {
    if (_placardView) return _placardView;
    _placardView = [[BDKUserPlacard alloc] init];
    [_placardView setUser:self.user];
    return _placardView;
}

- (UIBarButtonItem *)cancelButton {
    if (_cancelButton) return _cancelButton;
    _cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonTapped:)];
    return _cancelButton;
}

- (UIBarButtonItem *)logoutButton {
    if (_logoutButton) return _logoutButton;
    _logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonTapped:)];
    return _logoutButton;
}

#pragma mark - Actions

- (void)cancelButtonTapped:(UIBarButtonItem *)sender {
    if (self.modalDismissalBlock) {
        self.modalDismissalBlock();
        self.modalDismissalBlock = nil;
    }
}

- (void)logoutButtonTapped:(UIBarButtonItem *)sender {
    if (self.userTappedLogoutBlock) {
        self.userTappedLogoutBlock();
        self.userTappedLogoutBlock = nil;
    }
}

@end
