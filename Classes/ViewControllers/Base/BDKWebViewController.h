#import "BDKViewController.h"

/**
 A standard interface for an embedded web view. Defines self as a UIWebViewDelegate.
 */
@interface BDKWebViewController : BDKViewController <UIWebViewDelegate>

/**
 The web view embedded in the controller's view with an identical frame.
 */
@property (strong, nonatomic) UIWebView *webView;

/**
 The URL to be loaded when the view appears; this is set in an initializer.
 */
@property (readonly) NSURL *url;

/**
 Creates an instance with a code identifier and a specific table view style.
 
 @param identifier a string identifier with which to identify this view controller.
 @param url an NSURL to be used with the web view.
 @return an instance of `self`.
 */
+ (instancetype)vcWithIdentifier:(NSString *)identifier url:(NSURL *)url;

/**
 Creates an instance with a code identifier and a specific table view style.
 
 @param identifier a string identifier with which to identify this view controller.
 @param url an NSURL to be used with the web view.
 @return an instance of `self`.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier url:(NSURL *)url;

@end
