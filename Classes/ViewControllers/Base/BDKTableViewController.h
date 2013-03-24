#import "BDKViewController.h"

/** A base table view controller instance.
 */
@interface BDKTableViewController : BDKViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (readonly) UITableViewStyle tableViewStyle;

/** Creates an instance with a code identifier and a specific table view style.
 *  @param identifier a string identifier with which to identify this view controller.
 *  @param tableViewStyle a UITableViewStyle to be used with the table view.
 *  @return an instance of `self`.
 */
+ (id)vcWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle;

/** Creates an instance with a code identifier and a specific table view style.
 *  @param identifier a string identifier with which to identify this view controller.
 *  @param tableViewStyle a UITableViewStyle to be used with the table view.
 *  @return an instance of `self`.
 */
- (id)initWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle;

/** Registers cell types with the table view.
 */
- (void)registerCellTypes;

@end
