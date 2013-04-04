#import "BDKRoomCollectionCell.h"

#import "BDKGradientView.h"
#import <QuartzCore/QuartzCore.h>
#import <BDKGeometry/BDKGeometry.h>

#import "UIFont+App.h"

@implementation BDKRoomCollectionCell

@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.label];
        self.backgroundView = [[BDKGradientView alloc] initWithFrame:self.frame
                                                          startColor:[UIColor colorWithWhite:0.99 alpha:1]
                                                            endColor:[UIColor colorWithWhite:0.90 alpha:1]
                                                           direction:BDKGradientViewDirectionTopToBottom];
        self.selectedBackgroundView = [[BDKGradientView alloc] initWithFrame:self.frame
                                                          startColor:[UIColor colorWithWhite:1.00 alpha:1]
                                                            endColor:[UIColor colorWithWhite:0.98 alpha:1]
                                                           direction:BDKGradientViewDirectionTopToBottom];
        self.layer.borderColor = [[UIColor colorWithWhite:0.75 alpha:1] CGColor];
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)layoutSubviews
{
    [self.label centerInView:self direction:BDKGeometryCenterVertically];
}

#pragma mark - Properties

- (UILabel *)label
{
    if (_label) return _label;
    _label = [[UILabel alloc] initWithFrame:CGRectInset(self.contentView.frame, 10, 10)];
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont boldAppFontOfSize:19];
    _label.textColor = [UIColor colorWithWhite:0.15 alpha:1];
    return _label;
}

@end
