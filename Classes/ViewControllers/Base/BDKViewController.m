#import "BDKViewController.h"
#import "BDKAppDelegate.h"

#import "IFBKUser.h"

@interface BDKViewController ()

/** Internal method for calling a stored modal dismissal block.
 */
- (void)callModalDismissalBlock;

@end

@implementation BDKViewController

+ (id)vc {
    return [[self alloc] init];
}

+ (id)vcWithIdentifier:(NSString *)identifier {
    return [[self alloc] initWithIdentifier:identifier];
}

- (id)init {
    if (self = [super init]) {
        _identifier = @"";
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)identifier {
    if (self = [super init]) {
        _identifier = identifier;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.isModal) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                                 style:UIBarButtonItemStyleBordered
                                                                                target:self
                                                                                action:@selector(callModalDismissalBlock)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (!self.view.superview) {
        _identifier = nil;
        _modalDismissalBlock = nil;
    }
}

#pragma mark - Properties

- (CGRect)frame {
    return self.view.frame;
}

- (CGRect)bounds {
    return self.view.bounds;
}

#pragma mark - Methods

- (void)callModalDismissalBlock {
    if (!self.modalDismissalBlock) return;
    self.modalDismissalBlock();
    self.modalDismissalBlock = nil;
}

#pragma mark - Overrides

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
                   completion:(void (^)(void))completion {

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
