#import "BDKTableViewController.h"

/**
 Displays a list of rooms from which the user can join.
 */
@interface BDKRoomsViewController : BDKTableViewController

/**
 Loads up the necessary data into the collection view.
 */
- (void)refreshRooms;

/**
 Turns on/off access to the Profile button. Set flag to `YES` after profile data has been loaded.
 
 @param flag If `YES`, enables the profile button.
 */
- (void)enableProfileButton:(BOOL)flag;

@end
