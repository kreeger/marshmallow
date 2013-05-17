#import "BDKUserPlacard.h"

#import "IFBKUser.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface BDKUserPlacard ()

/** Displays the placard's title.
 */
@property (strong, nonatomic) UILabel *titleLabel;

/** The frame for the header banner.
 */
@property (nonatomic) CGRect headerRect;

/** The frame for the body.
 */
@property (nonatomic) CGRect bodyRect;

@end

@implementation BDKUserPlacard

@synthesize nameLabel = _nameLabel, emailLabel = _emailLabel, avatarImageView = _avatarImageView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.emailLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* gradientDark = [UIColor colorWithRed: 0.204 green: 0.204 blue: 0.204 alpha: 1];
    UIColor* gradientLight = [UIColor colorWithRed: 0.396 green: 0.396 blue: 0.396 alpha: 1];
    UIColor* bodyGradientDark = [UIColor colorWithRed: 0.89 green: 0.89 blue: 0.89 alpha: 1];
    UIColor* bodyGradientLight = [UIColor colorWithRed: 0.98 green: 0.98 blue: 0.98 alpha: 1];
    UIColor* strokeColor = [UIColor colorWithRed: 0.784 green: 0.784 blue: 0.784 alpha: 1];

    //// Gradient Declarations
    NSArray* headerGradientColors = [NSArray arrayWithObjects:
                                     (id)gradientLight.CGColor,
                                     (id)gradientDark.CGColor, nil];
    CGFloat headerGradientLocations[] = {0, 1};
    CGGradientRef headerGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)headerGradientColors, headerGradientLocations);
    NSArray* bodyGradientColors = [NSArray arrayWithObjects:
                                   (id)bodyGradientLight.CGColor,
                                   (id)bodyGradientDark.CGColor, nil];
    CGFloat bodyGradientLocations[] = {0, 1};
    CGGradientRef bodyGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)bodyGradientColors, bodyGradientLocations);

    //// Shadow Declarations
    UIColor* bodyShadow = bodyGradientDark;
    CGSize bodyShadowOffset = CGSizeMake(1.1, 1.1);
    CGFloat bodyShadowBlurRadius = 5;

    //// Frames
    CGRect frame = self.frame;


    //// Abstracted Attributes
    self.bodyRect = CGRectMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 10, CGRectGetWidth(frame) - 20, CGRectGetHeight(frame) - 20);
    self.headerRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.03125 + 0.5), CGRectGetMinY(frame) + 10, floor(CGRectGetWidth(frame) * 0.96875 + 0.5) - floor(CGRectGetWidth(frame) * 0.03125 + 0.5), 30);


    //// body Drawing
    UIBezierPath* bodyPath = [UIBezierPath bezierPathWithRoundedRect: self.bodyRect cornerRadius: 6];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, bodyShadowOffset, bodyShadowBlurRadius, bodyShadow.CGColor);
    CGContextBeginTransparencyLayer(context, NULL);
    [bodyPath addClip];
    CGContextDrawLinearGradient(context, bodyGradient,
                                CGPointMake(CGRectGetMidX(self.bodyRect), CGRectGetMinY(self.bodyRect)),
                                CGPointMake(CGRectGetMidX(self.bodyRect), CGRectGetMaxY(self.bodyRect)),
                                0);
    CGContextEndTransparencyLayer(context);
    CGContextRestoreGState(context);

    [strokeColor setStroke];
    bodyPath.lineWidth = 1;
    [bodyPath stroke];


    //// header Drawing
    UIBezierPath* headerPath = [UIBezierPath bezierPathWithRoundedRect: self.headerRect byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: CGSizeMake(6, 6)];
    [headerPath closePath];
    CGContextSaveGState(context);
    [headerPath addClip];
    CGContextDrawLinearGradient(context, headerGradient,
                                CGPointMake(CGRectGetMidX(self.headerRect), CGRectGetMinY(self.headerRect)),
                                CGPointMake(CGRectGetMidX(self.headerRect), CGRectGetMaxY(self.headerRect)),
                                0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(headerGradient);
    CGGradientRelease(bodyGradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.avatarImageView.frameOrigin = CGPointMake(22, 49);
    CGRect working = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame) + 12, CGRectGetMinY(self.avatarImageView.frame),
                                230, 100);

    CGSize size = [self.nameLabel.text sizeWithFont:self.nameLabel.font
                                  constrainedToSize:working.size
                                      lineBreakMode:NSLineBreakByWordWrapping];
    CGRect labelFrame = CGRectNull;
    CGRectDivide(working, &labelFrame, &working, size.height, CGRectMinYEdge);
    self.nameLabel.frame = labelFrame;
    size = [self.emailLabel.text sizeWithFont:self.emailLabel.font
                            constrainedToSize:working.size
                                lineBreakMode:NSLineBreakByWordWrapping];
    CGRectDivide(working, &labelFrame, &working, size.height, CGRectMinYEdge);
    self.emailLabel.frame = labelFrame;
}

#pragma mark - Properties

- (void)setUser:(IFBKUser *)user {
    self.nameLabel.text = user.name;
    self.emailLabel.text = user.emailAddress;
    // AFNetworking this thing.
    [self.avatarImageView setImageWithURL:user.avatarUrlValue];
    [self setNeedsLayout];
}

- (UILabel *)nameLabel {
    if (_nameLabel) return _nameLabel;
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = [UIFont boldAppFontOfSize:14];
    _nameLabel.backgroundColor = [UIColor clearColor];
    return _nameLabel;
}

- (UILabel *)emailLabel {
    if (_emailLabel) return _emailLabel;
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _emailLabel.font = [UIFont appFontOfSize:16];
    _emailLabel.backgroundColor = [UIColor clearColor];
    return _emailLabel;
}

- (UIImageView *)avatarImageView {
    if (_avatarImageView) return _avatarImageView;
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    _avatarImageView.backgroundColor = [UIColor clearColor];
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bannerRect, 12, 0)];
    _titleLabel.font = [UIFont boldAppFontOfSize:13];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"Your 37signals ID";
    return _titleLabel;
}

- (CGRect)bannerRect {
    return CGRectMake(10, 10, 300, 30);
}

@end
