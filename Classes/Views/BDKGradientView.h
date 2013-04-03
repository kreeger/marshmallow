#import <UIKit/UIKit.h>

typedef enum {
    BDKGradientViewDirectionLeftToRight,
    BDKGradientViewDirectionTopToBottom,
} BDKGradientViewDirection;

@interface BDKGradientView : UIView

@property (strong, nonatomic) UIColor *startColor;
@property (strong, nonatomic) UIColor *endColor;
@property (nonatomic) BDKGradientViewDirection direction;

- (id)initWithFrame:(CGRect)frame
         startColor:(UIColor *)startColor
           endColor:(UIColor *)endColor
          direction:(BDKGradientViewDirection)direction;

@end
