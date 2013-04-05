#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)veryBoldAppFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"AvenirNext-Bold" size:size];
}

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
