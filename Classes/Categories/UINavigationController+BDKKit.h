#import <UIKit/UIKit.h>

/** A convenience wrapper for some UINavigationController stuff.
 */
@interface UINavigationController (BDKKit)

/** Initializes a navigation controller with a root view.
 *  @param rootViewController the root view controller.
 *  @return an allocated instance of `self`.
 */
+ (id)controllerWithRootViewController:(UIViewController *)rootViewController;

/** Initializes a navigation controller with a root view and a tint color.
 *  @param rootViewController the root view controller.
 *  @param tintColor the color to tint the bar with.
 *  @return an allocated instance of `self`.
 */
+ (id)controllerWithRootViewController:(UIViewController *)rootViewController tintColor:(UIColor *)tintColor;

@end
