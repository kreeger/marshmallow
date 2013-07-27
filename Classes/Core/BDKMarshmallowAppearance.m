#import "BDKMarshmallowAppearance.h"

#import <BDKKit/BDKGradientView.h>
#import <BDKKit/UIView+BDKKit.h>

#import "NSUserDefaults+App.h"
#import "UIFont+App.h"

@implementation BDKMarshmallowAppearance

+ (void)setApplicationAppearance
{
    if (![NSUserDefaults deviceIsiOS7]) {
        id proxy = [UINavigationBar appearance];
        [proxy setTintColor:[UIColor whiteColor]];
        [proxy setTitleTextAttributes:(@{UITextAttributeFont: [UIFont boldAppFontOfSize:19],
                                         UITextAttributeTextColor: [UIColor blackColor],
                                         UITextAttributeTextShadowColor: [UIColor clearColor],
                                        })];
        //    BDKGradientView *gradient = [[BDKGradientView alloc] initWithFrame:CGRectMake(0, 0, 1, 44)
        //                                                            startColor:[UIColor colorWithWhite:1 alpha:1]
        //                                                              endColor:[UIColor colorWithWhite:0.95 alpha:1]
        //                                                             direction:BDKGradientViewDirectionTopToBottom];
        //    [proxy setBackgroundImage:[gradient renderAsImage] forBarMetrics:UIBarMetricsDefault];
        proxy = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
        [proxy setTitleTextAttributes:(@{UITextAttributeFont: [UIFont boldAppFontOfSize:13],
                                         UITextAttributeTextColor: [UIColor colorWithWhite:0.15 alpha:1],
                                         UITextAttributeTextShadowColor: [UIColor clearColor]})
                             forState:UIControlStateNormal];
        [proxy setTitleTextAttributes:(@{UITextAttributeFont: [UIFont boldAppFontOfSize:13],
                                         UITextAttributeTextColor: [UIColor grayColor],
                                         UITextAttributeTextShadowColor: [UIColor clearColor]})
                             forState:UIControlStateHighlighted];
        [proxy setTintColor:[UIColor whiteColor]];
    }
}

@end
