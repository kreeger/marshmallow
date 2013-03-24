#import "BDKTextFieldCell.h"

#import <BDKGeometry/BDKGeometry.h>
#import <QuartzCore/QuartzCore.h>

@interface BDKTextFieldCell ()

- (void)customizeTextLabel;

@end

@implementation BDKTextFieldCell

@synthesize textField = _textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self customizeTextLabel];
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect labelFrame = CGRectNull;
    CGRect textFieldFrame = CGRectNull;
    CGRectDivide(self.contentView.frame, &labelFrame, &textFieldFrame, 80, CGRectMinXEdge);
    self.textLabel.frame = labelFrame;
    self.textField.frame = textFieldFrame;
}

#pragma mark - Properties

- (UITextField *)textField
{
    if (_textField) return _textField;
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.font = [UIFont boldAppFontOfSize:18];
    _textField.layer.borderColor = [[UIColor blueColor] CGColor];
    _textField.layer.borderWidth = 1;
    return _textField;
}

#pragma mark - Methods

- (void)customizeTextLabel
{
    self.textLabel.textAlignment = NSTextAlignmentRight;
    self.textLabel.font = [UIFont appFontOfSize:14];
}

@end
