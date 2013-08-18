#import "BDKEnterKickCell.h"

#import <BDKGeometry/BDKGeometry.h>
#import <BDKKit/NSObject+BDKKit.h>
#import <BDKKit/UIView+BDKKit.h>
#import <FontasticIcons/FontasticIcons.h>
#import <Masonry/Masonry.h>

#import "UIFont+App.h"
#import "NSUserDefaults+App.h"

NSString * const BDKEnterKickCellID = @"BDKEnterKickCell";

@interface BDKEnterKickCell ()

/**
 Common cell layout and initialization instructions.
 */
- (void)setup;

@end

@implementation BDKEnterKickCell

@synthesize usernameLabel = _usernameLabel, iconView = _iconView;

- (void)setup {
    [super setup];
    
    [self.contentView addSubview:self.iconView];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timestampLabel.trailing).offset(10);
        make.height.equalTo(@14);
        make.width.equalTo(@14);
        make.centerY.equalTo(self.contentView).offset(2);
    }];
    
    [self.contentView addSubview:self.usernameLabel];
    [self.usernameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconView.trailing).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.baseline.equalTo(self.timestampLabel);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.usernameLabel.text = nil;
    self.iconView.icon = nil;
}

#pragma mark - Properties

- (UILabel *)usernameLabel {
    if (_usernameLabel) return _usernameLabel;
    _usernameLabel = [UILabel new];
    _usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _usernameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    _usernameLabel.contentMode = UIViewContentModeTopLeft;
    _usernameLabel.backgroundColor = [UIColor clearColor];
    _usernameLabel.textColor = [UIColor grayColor];
    _usernameLabel.numberOfLines = 0;
    _usernameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return _usernameLabel;
}

- (FIIconView *)iconView {
    if (_iconView) return _iconView;
    _iconView = [FIIconView new];
    _iconView.iconColor = [UIColor lightGrayColor];
    _iconView.backgroundColor = [UIColor clearColor];
    return _iconView;
}

#pragma mark - Methods

- (void)setUsername:(NSString *)username timestamp:(NSString *)timestamp isEntering:(BOOL)isEntering {
    NSString *appended = [NSString stringWithFormat:@"%@ %@", username, isEntering ? @"entered" : @"left"];
    self.usernameLabel.text = appended;
    self.timestampLabel.text = timestamp;
    
    // Based on the icon displayed, rotate the icon view. That way, "signing out" looks better (and the arrow faces
    // the other direction).
    if (isEntering) {
        self.iconView.icon = [FIFontAwesomeIcon signinIcon];
        self.iconView.transform = CGAffineTransformMakeRotation(0);
    } else {
        self.iconView.icon = [FIFontAwesomeIcon signoutIcon];
        self.iconView.transform = CGAffineTransformMakeRotation(M_PI);
    }
}

@end
