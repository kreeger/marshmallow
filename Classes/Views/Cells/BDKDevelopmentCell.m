#import "BDKDevelopmentCell.h"

#import <Masonry/Masonry.h>

#import "UIFont+App.h"
#import "NSUserDefaults+App.h"

NSString * const BDKDevelopmentCellID = @"BDKDevelopmentCell";

@interface BDKDevelopmentCell ()

/**
 Common cell layout and initialization instructions.
 */
- (void)setup;

@end

@implementation BDKDevelopmentCell

@synthesize bodyLabel = _bodyLabel;

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
    
    [self.contentView addSubview:self.bodyLabel];
    [self.bodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.bodyLabel.text = nil;
}

#pragma mark - Properties

- (UILabel *)bodyLabel {
    if (_bodyLabel) return _bodyLabel;
    _bodyLabel = [UILabel new];
    _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _bodyLabel.contentMode = UIViewContentModeTopLeft;
    _bodyLabel.backgroundColor = [UIColor clearColor];
    _bodyLabel.numberOfLines = 0;
    _bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return _bodyLabel;
}

#pragma mark - Methods

- (void)setBodyText:(NSString *)bodyText {
    self.bodyLabel.text = bodyText;
    [self invalidateIntrinsicContentSize];
}

@end
