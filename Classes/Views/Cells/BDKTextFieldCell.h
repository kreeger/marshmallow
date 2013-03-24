#import <UIKit/UIKit.h>

#define kBDKTextFieldCellID @"BDKTextFieldCell"

@interface BDKTextFieldCell : UITableViewCell

@property (readonly) UITextField *textField;

/** Gives first responder to the text field inside of the cell. Easy when called by tableView:didSelectRowAtIndexPath:.
 */
- (void)activateCell;

@end
