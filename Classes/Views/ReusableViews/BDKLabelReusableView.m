#import "BDKLabelReusableView.h"

#import <Masonry/Masonry.h>

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
    self.backgroundColor = [UIColor clearColor];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:self.label];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(4, 0, 4, 0));
    }];
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
    _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    _label.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _label.textAlignment = NSTextAlignmentCenter;
    return _label;
}

@end
