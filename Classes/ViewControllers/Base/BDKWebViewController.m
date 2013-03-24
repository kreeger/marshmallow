#import "BDKWebViewController.h"

@interface BDKWebViewController ()

@end

@implementation BDKWebViewController

+ (id)vcWithIdentifier:(NSString *)identifier url:(NSURL *)url
{
    return [[self alloc] initWithIdentifier:identifier url:url];
}

- (id)initWithIdentifier:(NSString *)identifier url:(NSURL *)url
{
    if (self = [super initWithIdentifier:identifier]) {
        _url = url;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self.webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UIWebView *)webView
{
    if (_webView) return _webView;
    _webView = [[UIWebView alloc] initWithFrame:self.frame];
    _webView.delegate = self;
    return _webView;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

@end
