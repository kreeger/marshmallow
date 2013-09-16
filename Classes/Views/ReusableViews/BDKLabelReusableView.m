#import "BDKLabelReusableView.h"

NSString * const BDKLabelReusableViewID = @"BDKLabelReusableView";

@interface BDKLabelReusableView ()

/**
 Common setup logic.
 */
- (void)setup;

@end

@implementation BDKLabelReusableView

@synthesize label = _label;

#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    [self setup];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup {
    [self addSubview:self.label];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.label.text = nil;
}

#pragma mark - Properties

- (UILabel *)label {
    if (_label) return _label;
    _label = [UILabel new];
    _label.textColor = [UIColor blackColor];
    _label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    return _label;
}

@end
