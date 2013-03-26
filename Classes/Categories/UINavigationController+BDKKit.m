#import "UINavigationController+BDKKit.h"

@implementation UINavigationController (BDKKit)

+ (id)controllerWithRootViewController:(UIViewController *)rootViewController {
    UINavigationController *instance = [[self alloc] initWithRootViewController:rootViewController];
    instance.modalPresentationStyle = rootViewController.modalPresentationStyle;
    instance.modalTransitionStyle = rootViewController.modalTransitionStyle;
    return instance;
}

+ (id)controllerWithRootViewController:(UIViewController *)rootViewController tintColor:(UIColor *)tintColor {
    UINavigationController *instance = [self controllerWithRootViewController:rootViewController];
    instance.navigationBar.tintColor = tintColor;
    return instance;
}

@end
