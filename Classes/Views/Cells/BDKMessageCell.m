#import "BDKMessageCell.h"
#import "BDKCellBackground.h"

#import <QuartzCore/QuartzCore.h>
#import <IFBKThirtySeven/IFBKCFMessage.h>
#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/NSObject+BDKKit.h>
#import <BDKKit/UIView+BDKKit.h>
#import <Masonry/Masonry.h>

#import "UIFont+App.h"
#import "NSUserDefaults+App.h"

NSString * const BDKMessageCellID = @"BDKMessageCell";

@interface BDKMessageCell ()

/**
 Common cell layout and initialization instructions.
 */
- (void)setup;

@end

@implementation BDKMessageCell

@synthesize bodyLabel = _bodyLabel, timestampLabel = _timestampLabel;

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
    [self.contentView addSubview:self.bodyLabel];

    [self.timestampLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(@60);
        make.leading.equalTo(self.contentView).offset(10);
        make.baseline.equalTo(self.bodyLabel);
    }];
    
    [self.bodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timestampLabel.trailing);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    line.userInteractionEnabled = NO;
    [self.contentView addSubview:line];
    
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-1);
        make.leading.equalTo(self.bodyLabel);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.bodyLabel.text = nil;
    self.timestampLabel.text = nil;
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

- (UILabel *)timestampLabel {
    if (_timestampLabel) return _timestampLabel;
    _timestampLabel = [UILabel new];
    _timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timestampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    _timestampLabel.textAlignment = NSTextAlignmentLeft;
    _timestampLabel.backgroundColor = [UIColor clearColor];
    return _timestampLabel;
}

#pragma mark - Methods

- (void)setMessageText:(NSString *)messageText timestampText:(NSString *)timestampText {
    self.bodyLabel.text = messageText;
    self.timestampLabel.text = timestampText;
    [self invalidateIntrinsicContentSize];
}

@end
