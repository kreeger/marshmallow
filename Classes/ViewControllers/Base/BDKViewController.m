#import "BDKViewController.h"

#import <EDColor/UIColor+Crayola.h>

@interface BDKViewController ()

@end

@implementation BDKViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    unless (self.view.superview) {
        _identifier = nil;
    }
}

#pragma mark - Properties

- (CGRect)frame
{
    return self.view.frame;
}

- (CGRect)bounds
{
    return self.view.bounds;
}

@end