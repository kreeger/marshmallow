#import "BDKUserViewController.h"

#import "MLLWUser.h"
#import "BDKUserPlacard.h"

#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/UIView+BDKKit.h>
#import <Masonry/Masonry.h>

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
 *  @return An instance of self.
 */
- (id)initWithIFBKUser:(MLLWUser *)user;

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

+ (id)vcWithIFBKUser:(MLLWUser *)user {
    return [[self alloc] initWithIFBKUser:user];
}

- (id)initWithIFBKUser:(MLLWUser *)user {
    if (self = [super initWithIdentifier:[NSString stringWithFormat:@"user:%@", user.name]]) {
        _user = user;
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.placardView];
    
    [self.placardView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    
    self.title = self.user.name;
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
    _placardView = [BDKUserPlacard new];
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
