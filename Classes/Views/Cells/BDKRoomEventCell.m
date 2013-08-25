#import "BDKRoomEventCell.h"

#import <Masonry/Masonry.h>

NSString * const BDKRoomEventCellID = @"BDKRoomEventCell";

@implementation BDKRoomEventCell

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
        make.top.equalTo(self.contentView).offset(10);
        make.width.equalTo(@60);
        make.leading.equalTo(self.contentView).offset(5);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.timestampLabel.text = nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p timestamp:%@>", NSStringFromClass([self class]), self, self.timestampLabel.text];
}

#pragma mark - Properties

- (UILabel *)timestampLabel {
    if (_timestampLabel) return _timestampLabel;
    _timestampLabel = [UILabel new];
    _timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timestampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    _timestampLabel.textColor = [UIColor lightGrayColor];
    _timestampLabel.textAlignment = NSTextAlignmentRight;
    _timestampLabel.backgroundColor = [UIColor clearColor];
    return _timestampLabel;
}

- (void)setTime:(NSDate *)time {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"h:mm a";
    self.timestampLabel.text = [formatter stringFromDate:time];
    formatter = nil;
}

@end
