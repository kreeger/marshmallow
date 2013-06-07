#import "BDKLoginViewController.h"
#import "BDKAppDelegate.h"
#import "BDKTextFieldCell.h"

#import <IFBKThirtySeven/IFBKLaunchpadClient.h>
#import <BDKKit/NSString+BDKKit.h>
#import <ObjectiveSugar/NSString+ObjectiveSugar.h>

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
    [self.webView loadRequest:[NSURLRequest requestWithURL:[IFBKLaunchpadClient launchpadURL]]];
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
        self.userGotAuthCodeBlock(authCode);
        self.userGotAuthCodeBlock = nil;
        return NO;
    }
    return YES;
}

@end
