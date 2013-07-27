#import "BDKUserPlacard.h"

#import "IFBKUser.h"

#import <Masonry/Masonry.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/UIView+BDKKit.h>

#import "UIFont+App.h"

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

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.titleLabel];
        [self addSubview:self.avatarImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.emailLabel];
        
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.leading.equalTo(self).offset(20);
            make.trailing.equalTo(self).offset(10);
            make.height.equalTo(@30);
        }];
        
        [self.avatarImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(10);
            make.leading.equalTo(self).offset(20);
            make.width.equalTo(@45);
            make.height.equalTo(@45);
        }];
        
        [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.bottom).offset(14);
            make.leading.equalTo(self.avatarImageView.trailing).offset(10);
        }];
        
        [self.emailLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.bottom);
            make.leading.equalTo(self.nameLabel);
        }];
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

#pragma mark - Properties

- (CGSize)intrinsicContentSize {
    return CGSizeMake(320, 116);
}

- (void)setUser:(IFBKUser *)user {
    self.nameLabel.text = user.name;
    self.emailLabel.text = user.emailAddress;
    // AFNetworking this thing.
    [self.avatarImageView setImageWithURL:user.avatarUrlValue];
    [self setNeedsUpdateConstraints];
}

- (UILabel *)nameLabel {
    if (_nameLabel) return _nameLabel;
    _nameLabel = [UILabel new];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.font = [UIFont boldAppFontOfSize:14];
    _nameLabel.backgroundColor = [UIColor clearColor];
    return _nameLabel;
}

- (UILabel *)emailLabel {
    if (_emailLabel) return _emailLabel;
    _emailLabel = [UILabel new];
    _emailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _emailLabel.font = [UIFont appFontOfSize:16];
    _emailLabel.backgroundColor = [UIColor clearColor];
    return _emailLabel;
}

- (UIImageView *)avatarImageView {
    if (_avatarImageView) return _avatarImageView;
    _avatarImageView = [UIImageView new];
    _avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatarImageView.backgroundColor = [UIColor clearColor];
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = [UILabel new];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
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
