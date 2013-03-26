#import "BDKLoginViewController.h"
#import "BDKLaunchpadClient.h"
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
    self.title = @"Login";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[BDKLaunchpadClient launchpadURL]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:@"marshmallow"]) {
        // Don't know if I like this shitty way of doing things.
        NSString *authCode = [request.URL.absoluteString split:@"="][1];
        DDLogUI(@"Request %@, nav type %i. Auth code %@.", request, navigationType, authCode);
        [BDKLaunchpadClient getAccessTokenForVerificationCode:authCode success:^(NSString *accessToken, NSString *refreshToken, NSDate *expiresOn) {
            DDLogAPI(@"Token %@ expires %@.", accessToken, expiresOn);
            
        } failure:nil];
    }
    return YES;
}

@end
