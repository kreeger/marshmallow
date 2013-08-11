#import "BDKTimestampCell.h"

#import <Masonry/Masonry.h>

#import "UIFont+App.h"
#import "NSUserDefaults+App.h"

NSString * const BDKTimestampCellID = @"BDKTimestampCell";

@interface BDKTimestampCell ()

/**
 Common cell layout and initialization instructions.
 */
- (void)setup;

@end

@implementation BDKTimestampCell

@synthesize timestampLabel = _timestampLabel;

- (instancetype)init {
    if (self = [super init]) {
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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contentView addSubview:self.timestampLabel];
    [self.timestampLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.timestampLabel.text = nil;
}

#pragma mark - Properties

- (UILabel *)timestampLabel {
    if (_timestampLabel) return _timestampLabel;
    _timestampLabel = [UILabel new];
    _timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timestampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    _timestampLabel.textAlignment = NSTextAlignmentCenter;
    _timestampLabel.backgroundColor = [UIColor clearColor];
    return _timestampLabel;
}

#pragma mark - Methods

- (void)setTimestampText:(NSString *)timestampText {
    self.timestampLabel.text = timestampText;
}

@end
