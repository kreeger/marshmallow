#import "BDKWebViewController.h"

@interface BDKLoginViewController : BDKWebViewController

@property (copy, nonatomic) void (^userGotAuthCodeBlock)(NSString *authCode);

@end
