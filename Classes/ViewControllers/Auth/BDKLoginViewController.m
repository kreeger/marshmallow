#import "BDKLoginViewController.h"
#import "BDKAppDelegate.h"
#import "BDKLaunchpadClient.h"
#import "BDKTextFieldCell.h"

#import "NSString+BDKKit.h"

@interface BDKLoginViewController ()

@property (nonatomic) BOOL authWasSubmitted;

@end

@implementation BDKLoginViewController

- (id)init {
    if (self = [super initWithIdentifier:@"login"]) {
        _authWasSubmitted = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[BDKLaunchpadClient launchpadURL]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
    navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeFormSubmitted &&
        [request.URL.absoluteString hasPrefix:@"marshmallow://"] &&
        !self.authWasSubmitted) {
        // Don't know if I like this shitty way of doing things.
        self.authWasSubmitted = YES;
        NSString *authCode = [request.URL.absoluteString split:@"="][1];
        DDLogUI(@"Request %@, nav type %i. Auth code %@.", request, navigationType, authCode);
        [BDKLaunchpadClient getAccessTokenForVerificationCode:authCode success:^(NSString *accessToken, NSString *refreshToken, NSDate *expiresOn) {
            DDLogAPI(@"Token %@ expires %@.", accessToken, expiresOn);
            [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:kBDKUserDefaultAccessToken];
            [[NSUserDefaults standardUserDefaults] setValue:refreshToken forKey:kBDKUserDefaultRefreshToken];
            [[NSUserDefaults standardUserDefaults] setValue:expiresOn forKey:kBDKUserDefaultTokenExpiresOn];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.userDidLoginBlock(accessToken);
            self.userDidLoginBlock = nil;
        } failure:^(NSError *error, NSInteger responseCode) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription
                                       delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            [self.webView reload];
        }];
        return NO;
    }
    return YES;
}

@end
