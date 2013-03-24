#import "BDKViewController.h"

@interface BDKWebViewController : BDKViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (readonly) NSURL *url;

/** Creates an instance with a code identifier and a specific table view style.
 *  @param identifier a string identifier with which to identify this view controller.
 *  @param url an NSURL to be used with the web view.
 *  @return an instance of `self`.
 */
+ (id)vcWithIdentifier:(NSString *)identifier url:(NSURL *)url;

/** Creates an instance with a code identifier and a specific table view style.
 *  @param identifier a string identifier with which to identify this view controller.
 *  @param url an NSURL to be used with the web view.
 *  @return an instance of `self`.
 */
- (id)initWithIdentifier:(NSString *)identifier url:(NSURL *)url;

@end
