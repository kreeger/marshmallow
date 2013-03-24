#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)boldAppFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"RobotoCondensed-Bold" size:size];
}

+ (UIFont *)italicAppFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"RobotoCondensed-Italic" size:size];
}

+ (UIFont *)appFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"RobotoCondensed-Regular" size:size];
}

@end
