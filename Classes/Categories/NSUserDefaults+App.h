#import <Foundation/Foundation.h>

/** Handy wrappers on top of NSUserDefaults to access common values for the application.
 */
@interface NSUserDefaults (App)

/** If `YES`, the device is a 4-inch device.
 */
+ (BOOL)deviceIs4Inch;

/** If `YES`, the device is an iPad.
 */
+ (BOOL)deviceIsPad;

@end
