#import "BDKViewController.h"
#import "BDKAppDelegate.h"

#import "IFBKUser.h"

#import <EDColor/UIColor+Crayola.h>

@interface BDKViewController ()

/** Internal method for calling a stored modal dismissal block.
 */
- (void)callModalDismissalBlock;

@end

@implementation BDKViewController

@synthesize currentUser = _currentUser;

+ (id)vc
{
    return [[self alloc] init];
}

+ (id)vcWithIdentifier:(NSString *)identifier
{
    return [[self alloc] initWithIdentifier:identifier];
}

- (id)init {
    if (self = [super init]) {
        _identifier = @"";
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        _identifier = identifier;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor colorWithCrayola:@"Atomic Tangerine"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isModal) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(callModalDismissalBlock)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _identifier = nil;
        _currentUser = nil;
        _modalDismissalBlock = nil;
    }
}

#pragma mark - Properties

- (NSNumber *)currentUserId
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultCurrentUserId];
}

- (IFBKUser *)currentUser
{
    return self.currentUserId ? [IFBKUser findFirstByAttribute:@"identifier" withValue:self.currentUserId] : nil;
}

- (CGRect)frame
{
    return self.view.frame;
}

- (CGRect)bounds
{
    return self.view.bounds;
}

#pragma mark - Methods

- (void)callModalDismissalBlock
{
    unless (self.modalDismissalBlock) return;
    self.modalDismissalBlock();
    self.modalDismissalBlock = nil;
}

#pragma mark - Overrides

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
                   completion:(void (^)(void))completion
{

    if ([viewControllerToPresent isKindOfClass:[BDKViewController class]])
        ((BDKViewController *)viewControllerToPresent).isModal = YES;
    else if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
        UIViewController *topController = ((UINavigationController *)viewControllerToPresent).topViewController;
        if ([topController isKindOfClass:[BDKViewController class]]) {
            ((BDKViewController *)topController).isModal = YES;
        }
    }

    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
