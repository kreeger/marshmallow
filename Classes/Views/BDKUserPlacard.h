#import <UIKit/UIKit.h>

@class IFBKUser;

/** A "37signals user badge" view.
 */
@interface BDKUserPlacard : UIView

/** The label displaying the user's name.
 */
@property (readonly) UILabel *nameLabel;

/** The label displaying the user's email address.
 */
@property (readonly) UILabel *emailLabel;

/** The label displaying the user's email address.
 */
@property (readonly) UIImageView *avatarImageView;

/** Handles mapping the user's attributes to the labels and views inside of this view.
 *  @param user The IFBKUser instance to use for this view.
 */
- (void)setUser:(IFBKUser *)user;

@end
