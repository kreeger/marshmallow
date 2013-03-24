#import "BDKViewController.h"

@interface BDKViewController ()

@end

@implementation BDKViewController

+ (id)vcWithIdentifier:(NSString *)identifier {
    return [[self alloc] initWithName:identifier];
}

- (id)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        _identifier = identifier;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _identifier = nil;
    }
}

@end
