#import "BDKUserReusableView.h"

#import <Masonry/Masonry.h>

NSString * const BDKUserResuableViewID = @"BDKUserResuableView";

@interface BDKUserReusableView ()

/**
 Common view layout and initialization instructions.
 */
- (void)setup;

@end

@implementation BDKUserReusableView

@synthesize userLabel = _userLabel;

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:self.userLabel];
    [self.userLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.top.equalTo(self);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.userLabel.text = nil;
}

#pragma mark - Properties

- (UILabel *)userLabel {
    if (_userLabel) return _userLabel;
    _userLabel = [UILabel new];
    _userLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _userLabel.textColor = [UIColor whiteColor];
    _userLabel.backgroundColor = [UIColor clearColor];
    _userLabel.font = [UIFont systemFontOfSize:14];
    return _userLabel;
}

#pragma mark - Public methods

- (void)setUserName:(NSString *)userName {
    self.userLabel.text = userName;
}

@end
