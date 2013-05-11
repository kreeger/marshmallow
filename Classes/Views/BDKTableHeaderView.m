#import "BDKTableHeaderView.h"
#import "BDKGradientView.h"

@interface BDKTableHeaderView ()

/** The label to use for the title text in this view.
 */
@property (strong, nonatomic) UILabel *label;

@end

@implementation BDKTableHeaderView

@synthesize title = _title;

+ (id)headerWithTitle:(NSString *)title width:(CGFloat)width {
    return [[self alloc] initWithTitle:title width:width];
}

- (id)initWithTitle:(NSString *)title width:(CGFloat)width {
    if (self = [super initWithFrame:CGRectMake(0, 0, width, kBDKTableHeaderViewHeight)]) {
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:1];
        self.userInteractionEnabled = YES;
        [self addSubview:self.label];
        self.title = title;
    }
    return self;
}

#pragma mark - Properties

- (void)setTitle:(NSString *)title {
    self.label.text = title;
    _title = title;
}

- (UILabel *)label {
    if (_label) return _label;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frameWidth - 10, self.frameHeight)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.shadowColor = [UIColor darkGrayColor];
    _label.shadowOffset = CGSizeMake(0, 1);
    _label.font = [UIFont boldAppFontOfSize:16];
    return _label;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGGradientRef backgroundGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0f, 1.0f };
    CGFloat components[8] = { 144.0f/255.0f, 159.0f/255.0f, 171.0f/255.0f, 1.0f,
        /* start */ 183.0f/255.0f, 192.0f/255.0f, 200.0f/255.0f, 1.0f /* end */ };

    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    backgroundGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);

    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMinY(currentBounds));
    CGPoint bottomCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));

    CGContextDrawLinearGradient(context, backgroundGradient, topCenter, bottomCenter, 0);

    UIColor *topBorderLineColor = [UIColor colorWithRed:113.0f/255.0f  green:125.0f/255.0f blue:133.0f/255.0f alpha:1.0];
    UIColor *secondLineColor = [UIColor colorWithRed:165.0f/255.0f  green:177.0f/255.0f blue:187.0f/255.0f alpha:1.0];
    UIColor *bottomBorderLineColor = [UIColor colorWithRed:151.0f/255.0f  green:157.0f/255.0f blue:164.0f/255.0f alpha:1.0];

    [topBorderLineColor setFill];
    CGContextFillRect(context, CGRectMake(0, 0, CGRectGetMaxX(currentBounds), 1));

    [bottomBorderLineColor setFill];
    CGContextFillRect(context, CGRectMake(0, CGRectGetMaxY(currentBounds)-1, CGRectGetMaxX(currentBounds), 1));

    [secondLineColor setFill];
    CGContextFillRect(context, CGRectMake(0, 1, CGRectGetMaxX(currentBounds), 1));

    [super drawRect:rect];
}


@end
