#import "BDKMessageCell.h"
#import "BDKCellBackground.h"

#import <QuartzCore/QuartzCore.h>
#import <IFBKThirtySeven/IFBKCFMessage.h>
#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/NSObject+BDKKit.h>
#import <BDKKit/UIView+BDKKit.h>

#import "UIFont+App.h"

@implementation BDKMessageCell

@synthesize typeLabel = _typeLabel, bodyLabel = _bodyLabel, timestampLabel = _timestampLabel;

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self attribute:NSLayoutAttributeWidth
                                                    multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self attribute:NSLayoutAttributeHeight
                                                    multiplier:1 constant:0]];
    
    [self.contentView addSubview:self.timestampLabel];
    [self.contentView addSubview:self.bodyLabel];
    [self.contentView addSubview:self.typeLabel];
    
    NSDictionary *views = @{@"timestamp": self.timestampLabel, @"body": self.bodyLabel, @"type": self.typeLabel};
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[type]" options:0
                                                                             metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[timestamp(==type)]" options:0
                                                                             metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[type]-[timestamp]-10-|" options:0
                                                                             metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[type]-5-[body]" options:0
                                                                             metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[body]-10-|" options:0
                                                                             metrics:nil views:views]];
}

#pragma mark - Properties

- (void)setMessage:(IFBKCFMessage *)message {
    _message = message;
    if (!_message) return;
    
    self.bodyLabel.text = nil;
    self.timestampLabel.text = nil;
    self.typeLabel.text = nil;
    
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
    _typeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    _typeLabel.backgroundColor = [UIColor clearColor];
    return _typeLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel) return _bodyLabel;
    _bodyLabel = [UILabel new];
    _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _bodyLabel.contentMode = UIViewContentModeTopLeft;
    _bodyLabel.backgroundColor = [UIColor clearColor];
    _bodyLabel.numberOfLines = 0;
    _bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _bodyLabel.layer.borderColor = [[UIColor redColor] CGColor];
    _bodyLabel.layer.borderWidth = 1;
    return _bodyLabel;
}

- (UILabel *)timestampLabel {
    if (_timestampLabel) return _timestampLabel;
    _timestampLabel = [UILabel new];
    _timestampLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timestampLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    _timestampLabel.textAlignment = NSTextAlignmentRight;
    _timestampLabel.backgroundColor = [UIColor clearColor];
    return _timestampLabel;
}

@end
