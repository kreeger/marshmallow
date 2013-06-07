#import "BDKTextFieldCell.h"

#import <BDKGeometry/BDKGeometry.h>
#import <QuartzCore/QuartzCore.h>

#import "UIFont+App.h"

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect labelFrame = CGRectNull;
    CGRect textFieldFrame = CGRectNull;
    CGRectDivide(CGRectInset(self.contentView.frame, 0, 2), &labelFrame, &textFieldFrame, 70, CGRectMinXEdge);
    self.textLabel.frame = labelFrame;
    self.textField.frame = CGRectInset(textFieldFrame, 10, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) [self activateCell];
}

#pragma mark - Properties

- (UITextField *)textField
{
    if (_textField) return _textField;
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.font = [UIFont boldAppFontOfSize:18];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    return _textField;
}

#pragma mark - Methods

- (void)customizeTextLabel
{
    self.textLabel.textAlignment = NSTextAlignmentRight;
    self.textLabel.font = [UIFont appFontOfSize:14];
}

- (void)activateCell
{
    [self.textField becomeFirstResponder];
}

@end
