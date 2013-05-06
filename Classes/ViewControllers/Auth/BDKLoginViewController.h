#import "BDKWebViewController.h"

@interface BDKLoginViewController : BDKWebViewController

@property (copy, nonatomic) void (^userDidLoginBlock)(NSString *accessToken);

@end
