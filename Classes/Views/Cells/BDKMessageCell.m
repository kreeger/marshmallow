#import "BDKMessageCell.h"

#import <BDKThirtySeven/BDKCFMessage.h>

@interface BDKMessageCell ()

@end

@implementation BDKMessageCell

@synthesize typeLabel = _typeLabel, bodyLabel = _bodyLabel, timestampLabel = _timestampLabel, senderLabel = _senderLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.senderLabel];
        [self.contentView addSubview:self.timestampLabel];
        [self.contentView addSubview:self.bodyLabel];
        [self.contentView addSubview:self.typeLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect working = self.contentView.frame;
    CGRect frame = CGRectNull;
    
    CGRectDivide(working, &frame, &working, 20, CGRectMinYEdge);
    self.typeLabel.frame = frame;

    CGRectDivide(working, &frame, &working, 20, CGRectMinYEdge);
    self.senderLabel.frame = frame;

    CGRectDivide(working, &frame, &working, 60, CGRectMinYEdge);
    self.bodyLabel.frame = frame;

    CGRectDivide(working, &frame, &working, 20, CGRectMinYEdge);
    self.timestampLabel.frame = frame;
    
}

#pragma mark - Properties

- (void)setMessage:(BDKCFMessage *)message {
    _message = message;
    if (!_message) return;

    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"YYYY-mm-dd hh:mm:ss";
    self.textLabel.text = nil;
    if (![(NSNull *)message.userIdentifier isEqual:[NSNull null]])
        self.senderLabel.text = [message.userIdentifier stringValue];
    self.timestampLabel.text = [f stringFromDate:message.createdAt];
    self.typeLabel.text = message.type;

    if (![(NSNull *)message.body isEqual:[NSNull null]]) {
        self.bodyLabel.text = message.body;
    }
}

- (UILabel *)typeLabel {
    if (_typeLabel) return _typeLabel;
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _typeLabel.font = [UIFont appFontOfSize:12];
    _typeLabel.backgroundColor = [UIColor clearColor];
    _typeLabel.layer.borderColor = [[UIColor greenColor] CGColor];
    _typeLabel.layer.borderWidth = 1;
    return _typeLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel) return _bodyLabel;
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.font = [UIFont appFontOfSize:14];
    _bodyLabel.backgroundColor = [UIColor clearColor];
    _bodyLabel.layer.borderColor = [[UIColor redColor] CGColor];
    _bodyLabel.layer.borderWidth = 1;
    return _bodyLabel;
}

- (UILabel *)timestampLabel {
    if (_timestampLabel) return _timestampLabel;
    _timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timestampLabel.font = [UIFont appFontOfSize:12];
    _timestampLabel.backgroundColor = [UIColor clearColor];
    _timestampLabel.layer.borderColor = [[UIColor blueColor] CGColor];
    _timestampLabel.layer.borderWidth = 1;
    return _timestampLabel;
}

- (UILabel *)senderLabel {
    if (_senderLabel) return _senderLabel;
    _senderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _senderLabel.font = [UIFont appFontOfSize:12];
    _senderLabel.backgroundColor = [UIColor clearColor];
    _senderLabel.layer.borderColor = [[UIColor orangeColor] CGColor];
    _senderLabel.layer.borderWidth = 1;
    return _senderLabel;
}

@end
