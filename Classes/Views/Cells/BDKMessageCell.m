#import "BDKMessageCell.h"
#import "BDKCellBackground.h"

#import <Masonry/Masonry.h>

#import "UIFont+App.h"

NSString * const BDKMessageCellID = @"BDKMessageCell";

@implementation BDKMessageCell

@synthesize bodyLabel = _bodyLabel;

- (void)setup {
    [super setup];
    
    self.paste = NO;
    
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
    self.paste = NO;
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

- (void)setMessage:(NSString *)message timestamp:(NSString *)timestamp {
    self.bodyLabel.text = message;
    self.timestampLabel.text = timestamp;
    [self invalidateIntrinsicContentSize];
}

- (void)setPaste:(BOOL)paste {
    if (paste) {
        self.bodyLabel.font = [UIFont monospaceFontOfSize:13];
    } else {
        self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
}

@end
