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
 Holds the avatar of the user.
 */
@property (readonly) UIImageView *userImageView;

/**
 Sets the user name displayed in the label.
 
 @param userName The user's name to be displayed in the label.
 */
- (void)setUserName:(NSString *)userName;

/**
 Sets the URL of the avatar to be displayed in the avatar view. Will be retrieved asynchronously.
 
 @param avatarURL The URL of the avatar to retrieve.
 */
- (void)setAvatarURL:(NSURL *)avatarURL;

@end
