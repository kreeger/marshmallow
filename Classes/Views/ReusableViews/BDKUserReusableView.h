#import <UIKit/UIKit.h>

extern NSString * const BDKUserResuableViewID;

/**
 Shows the user that sent the messages in a given group.
 */
@interface BDKUserReusableView : UICollectionReusableView

/**
 Holds the name of the user.
 */
@property (readonly) UILabel *userLabel;

/**
 Sets the user name displayed in the label.
 
 @param userName The user's name to be displayed in the label.
 */
- (void)setUserName:(NSString *)userName;

@end
