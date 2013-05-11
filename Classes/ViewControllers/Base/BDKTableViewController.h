#import "BDKViewController.h"

/** A base table view controller instance.
 */
@interface BDKTableViewController : BDKViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (readonly) UITableViewStyle tableViewStyle;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL pullToRefreshEnabled;

/** Creates an instance with a code identifier and a specific table view style.
 *
 *  @param identifier a string identifier with which to identify this view controller.
 *  @param tableViewStyle a UITableViewStyle to be used with the table view.
 *  @return an instance of `self`.
 */
+ (id)vcWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle;

/** Creates an instance with a code identifier and a specific table view style.
 *
 *  @param identifier a string identifier with which to identify this view controller.
 *  @param tableViewStyle a UITableViewStyle to be used with the table view.
 *  @return an instance of `self`.
 */
- (id)initWithIdentifier:(NSString *)identifier tableViewStyle:(UITableViewStyle)tableViewStyle;

/** Registers cell types with the table view.
 */
- (void)registerCellTypes;

/** Fired when the pull-to-refresh control has been triggered.
 * 
 *  @param sender The sender of the pull-to-refresh event.
 */
- (void)pullToRefreshPulled:(UIRefreshControl *)sender;

@end
