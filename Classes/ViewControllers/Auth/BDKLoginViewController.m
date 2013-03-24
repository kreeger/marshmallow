#import "BDKLoginViewController.h"
#import "BDKTextFieldCell.h"

#import "NSString+BDKKit.h"

@interface BDKLoginViewController ()

@end

@implementation BDKLoginViewController

- (id)init
{
    if (self = [super initWithIdentifier:@"login"]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *clientID = @"";
    NSString *clientSecret = @"";
    NSString *urlString = NSStringWithFormat(kBDKLaunchpadURL, clientID, clientSecret);
    [self.webView loadRequest:[NSURLRequest requestWithURL:urlString.urlValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

#pragma mark - Parent overrides

@end
