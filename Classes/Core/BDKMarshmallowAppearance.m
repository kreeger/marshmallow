#import "BDKMarshmallowAppearance.h"

@implementation BDKMarshmallowAppearance

+ (void)setApplicationAppearance
{
    id proxy = [UINavigationBar appearance];
    [proxy setTitleTextAttributes:(@{UITextAttributeFont: [UIFont veryBoldAppFontOfSize:20],
                                   UITextAttributeTextColor: [UIColor blackColor],
                                   UITextAttributeTextShadowColor: [UIColor clearColor]})];
    [proxy setTintColor:[UIColor whiteColor]];

    proxy = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    [proxy setTitleTextAttributes:(@{UITextAttributeFont: [UIFont boldAppFontOfSize:13],
                                   UITextAttributeTextColor: [UIColor colorWithWhite:0.15 alpha:1],
                                   UITextAttributeTextShadowColor: [UIColor clearColor]})
                         forState:UIControlStateNormal];
    [proxy setTitleTextAttributes:(@{UITextAttributeFont: [UIFont boldAppFontOfSize:13],
                                   UITextAttributeTextColor: [UIColor grayColor],
                                   UITextAttributeTextShadowColor: [UIColor clearColor]})
                         forState:UIControlStateHighlighted];
}

@end
