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

@interface BDKMessageCell ()

- (void)setupCell;

@end

@implementation BDKMessageCell

@synthesize typeLabel = _typeLabel, bodyLabel = _bodyLabel, timestampLabel = _timestampLabel;

- (instancetype)init {
    if (self = [super init]) {
        [self setupCell];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupCell];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    [self.contentView addBorderWithColor:[UIColor grayColor] width:1];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contentView addSubview:self.timestampLabel];
    [self.contentView addSubview:self.bodyLabel];
    [self.contentView addSubview:self.typeLabel];
    
    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView);
    }];
    [self.timestampLabel makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.typeLabel);
        make.top.equalTo(self.contentView);
        make.leading.equalTo(self.typeLabel.right);
        make.trailing.equalTo(self.contentView).offset(-10);
    }];
    [self.bodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).offset(-10);
        make.leading.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.typeLabel.bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.bodyLabel.text = nil;
    self.timestampLabel.text = nil;
    self.typeLabel.text = nil;
}

#pragma mark - Properties

- (void)setMessage:(IFBKCFMessage *)message {
    _message = message;
    if (!_message) return;
    
    self.timestampLabel.text = message.createdAtDisplay;
    self.typeLabel.text = message.type;

    if ([message.body isNotNull]) {
        self.bodyLabel.text = message.body;
        [self invalidateIntrinsicContentSize];
    }
}

- (UILabel *)typeLabel {
    if (_typeLabel) return _typeLabel;
    _typeLabel = [UILabel new];
    _typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    if ([NSUserDefaults deviceIsiOS7])
        _typeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    else
        _typeLabel.font = [UIFont appFontOfSize:13];
    _typeLabel.backgroundColor = [UIColor clearColor];
    return _typeLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel) return _bodyLabel;
    _bodyLabel = [UILabel new];
    _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    if ([NSUserDefaults deviceIsiOS7])
        _bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    else
        _bodyLabel.font = [UIFont appFontOfSize:15];
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
    if ([NSUserDefaults deviceIsiOS7])
        _timestampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    else
        _timestampLabel.font = [UIFont appFontOfSize:13];
    _timestampLabel.textAlignment = NSTextAlignmentRight;
    _timestampLabel.backgroundColor = [UIColor clearColor];
    return _timestampLabel;
}

@end
