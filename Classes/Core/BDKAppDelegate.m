#import "BDKAppDelegate.h"
#import "BDKLoginViewController.h"
#import "BDKRoomsViewController.h"
#import "UINavigationController+BDKKit.h"
#import <CocoaLumberjack/DDTTYLogger.h>

#import "BDKLaunchpadClient.h"
#import "BDKLPModels.h"

@interface BDKAppDelegate ()

/** Initializes user defaults.
 */
- (void)kickstartUserDefaults;

- (void)refreshUserData;

@end

@implementation BDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    // check if the user is logged in first
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken]) {
        [self refreshUserData];
        [BDKLaunchpadClient getAuthorization:^(BDKLPAuthorizationData *authData) {
            NSArray *accounts = [authData.accounts select:^BOOL(BDKLPAccount *acc) {
                return acc.type == BDKLPAccountTypeCampfire;
            }];
            DDLogAPI(@"%@", accounts.first);
        } failure:^(NSError *error, NSInteger responseCode) {
            DDLogError(@"Error! %@.", error);
        }];
        
        BDKRoomsViewController *vc = [BDKRoomsViewController vc];
        UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
        self.window.rootViewController = nav;
    } else {
        BDKLoginViewController *vc = [BDKLoginViewController vc];
        UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
        self.window.rootViewController = nav;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}

#pragma mark - Methods

- (void)kickstartUserDefaults
{
    NSDictionary *userDefaults = @{};
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)refreshUserData
{

}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
