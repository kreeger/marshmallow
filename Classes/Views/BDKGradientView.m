#import "BDKGradientView.h"

@implementation BDKGradientView

- (id)initWithFrame:(CGRect)frame
         startColor:(UIColor *)startColor
           endColor:(UIColor *)endColor
          direction:(BDKGradientViewDirection)direction {
    if (self = [super initWithFrame:frame]) {
        self.startColor = startColor;
        self.endColor = endColor;
        self.direction = direction;
        self.opaque = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    NSArray *colors = (@[
                       (__bridge id)[self.startColor CGColor],
                       (__bridge id)[self.endColor CGColor]
                       ]);
    CGGradientRef gradient = CGGradientCreateWithColors(rgb, (__bridge CFArrayRef)colors, locations);

    CGPoint startPoint;
    CGPoint endPoint;
    switch (self.direction) {
        case BDKGradientViewDirectionLeftToRight:
            startPoint = CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds));
            endPoint = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
            break;
        case BDKGradientViewDirectionTopToBottom:
            startPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds));
            endPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
            break;
        default:
            break;
    }

    CGContextSaveGState(c);
    CGContextAddRect(c, rect);
    CGContextClip(c);
    CGContextDrawLinearGradient(c, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(c);

    CGGradientRelease(gradient);
    CGColorSpaceRelease(rgb);
}

@end
