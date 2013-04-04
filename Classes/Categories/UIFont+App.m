#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)boldAppFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNext-DemiBold" size:size];
}

+ (UIFont *)italicAppFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNext-Italic" size:size];
}

+ (UIFont *)appFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNext-Regular" size:size];
}

@end
