#import "BDKRoomEventCell.h"

extern NSString * const BDKEnterKickCellID;

@class FIIconView;

/**
 A collection view cell intended to represent a user entering or leaving a room.
 */
@interface BDKEnterKickCell : BDKRoomEventCell

/**
 The label that displays the username.
 */
@property (readonly) UILabel *usernameLabel;

/**
 The view that displays the join or kick icon.
 */
@property (readonly) FIIconView *iconView;

/**
 Handles setting the internal text of usernameLabel.
 
 @param username The text of the username to use.
 @param timestamp The text to use for the timestamp.
 @param isEntering If `YES`, the cell displays a user entering the room; if `NO`, the cell displays the user leaving.
 */
- (void)setUsername:(NSString *)username timestamp:(NSString *)timestamp isEntering:(BOOL)isEntering;

@end
