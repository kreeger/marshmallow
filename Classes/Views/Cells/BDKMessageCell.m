#import "BDKMessageCell.h"
#import "BDKCellBackground.h"

#import <QuartzCore/QuartzCore.h>
#import <IFBKThirtySeven/IFBKCFMessage.h>
#import <BDKGeometry/BDKGeometry.h>

#import "UIFont+App.h"

@interface BDKMessageCell ()

/** The frame where cell content actually belongs.
 */
@property (readonly) CGRect insetFrame;

- (void)recalculateBodyLabelFrame;

@end

@implementation BDKMessageCell

@synthesize typeLabel = _typeLabel, bodyLabel = _bodyLabel, timestampLabel = _timestampLabel, cellBack = _cellBack;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.clipsToBounds = YES;
//        [self.contentView addSubview:self.cellBack];
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
    
    CGRect working = self.insetFrame;
    CGRect frame = CGRectNull;
    
    CGRectDivide(working, &frame, &working, 20, CGRectMinYEdge);
    self.typeLabel.frame = frame;

    CGRectDivide(working, &frame, &working, 20, CGRectMinYEdge);
    self.timestampLabel.frame = frame;

    CGRectDivide(working, &frame, &working, 60, CGRectMinYEdge);
    self.bodyLabel.frame = frame;
    [self recalculateBodyLabelFrame];
    
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

    if (![(NSNull *)message.body isEqual:[NSNull null]]) {
        self.bodyLabel.text = message.body;
        [self recalculateBodyLabelFrame];
    }
}

- (UILabel *)typeLabel {
    if (_typeLabel) return _typeLabel;
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _typeLabel.font = [UIFont appFontOfSize:12];
    _typeLabel.backgroundColor = [UIColor clearColor];
    return _typeLabel;
}

- (UILabel *)bodyLabel {
    if (_bodyLabel) return _bodyLabel;
    _bodyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _bodyLabel.font = [UIFont appFontOfSize:14];
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
    _timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _timestampLabel.font = [UIFont appFontOfSize:12];
    _timestampLabel.backgroundColor = [UIColor clearColor];
    return _timestampLabel;
}

//- (BDKCellBackground *)cellBack {
//    if (_cellBack) return _cellBack;
//    _cellBack = [[BDKCellBackground alloc] initWithFrame:self.contentView.frame];
//    return _cellBack;
//}

- (CGRect)insetFrame {
    return CGRectInset(self.contentView.frame, 10, 10);
}

- (void)setBackPosition:(BDKMessageCellPosition)backPosition {
    _backPosition = backPosition;
    [self setNeedsLayout];
}

#pragma mark - Methods

- (void)recalculateBodyLabelFrame {
    CGSize size = [self.bodyLabel.text sizeWithFont:self.bodyLabel.font
                                  constrainedToSize:CGSizeMake(self.contentView.frame.size.width, CGFLOAT_MAX)
                                      lineBreakMode:NSLineBreakByWordWrapping];
    self.bodyLabel.frameHeight = size.height;
}

@end
