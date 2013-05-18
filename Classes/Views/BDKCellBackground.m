#import "BDKCellBackground.h"

@implementation BDKCellBackground

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 0.918 green: 0.918 blue: 0.918 alpha: 1];
    UIColor* strokeColor = [UIColor colorWithRed: 0.667 green: 0.667 blue: 0.667 alpha: 1];
    UIColor* gradientColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)gradientColor.CGColor,
                               (id)fillColor.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);

    //// Frames
    CGRect frame = self.frame;

    //// bubbleTop Drawing
    CGRect bubbleTopRect = CGRectMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 10, CGRectGetWidth(frame) - 20, CGRectGetHeight(frame) - 20);
    UIBezierPath* bubbleTopPath = [UIBezierPath bezierPathWithRoundedRect: bubbleTopRect cornerRadius: 4];
    CGContextSaveGState(context);
    [bubbleTopPath addClip];
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMidX(bubbleTopRect), CGRectGetMinY(bubbleTopRect)),
                                CGPointMake(CGRectGetMidX(bubbleTopRect), CGRectGetMaxY(bubbleTopRect)),
                                0);
    CGContextRestoreGState(context);
    [strokeColor setStroke];
    bubbleTopPath.lineWidth = 1;
    [bubbleTopPath stroke];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    

}

@end
