#import "UIFont+App.h"

@implementation UIFont (App)

+ (UIFont *)veryBoldAppFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont *)boldAppFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

+ (UIFont *)italicAppFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Italic" size:size];
}

+ (UIFont *)appFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

+ (UIFont *)monospaceFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Menlo" size:size];
}

@end
