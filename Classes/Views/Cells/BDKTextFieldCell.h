#import <UIKit/UIKit.h>

#define kBDKTextFieldCellID @"BDKTextFieldCell"

/** A table view cell containing a text field. Currently not used.
 */
@interface BDKTextFieldCell : UITableViewCell

/** The text field inside the cell; the object itself cannot be altered, but its properties can.
 */
@property (readonly) UITextField *textField;

/** Gives first responder to the text field inside of the cell. Easy when called by tableView:didSelectRowAtIndexPath:.
 */
- (void)activateCell;

@end
