#import "BDKAppDelegate.h"

#import "BDKLoginViewController.h"
#import "BDKRoomsViewController.h"

#import "BDKAPIKeyManager.h"
#import "BDKConstants.h"
#import "MLLWAccountsManager.h"

#import <BDKKit/UINavigationController+BDKKit.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <BDKKit/UIDevice+BDKKit.h>

@interface BDKAppDelegate ()

/** Initializes user defaults.
 */
- (void)kickstartUserDefaults;

/** Configures CocoaLumberjack.
 */
- (void)configureLogging;

/** Sets up our common Launchpad instance with the proper OAuth keys.
 */
- (void)configureAccountsManager;

/** Presents the login view controller as the main center view controller.
 */
- (void)setLoginControllerAsCenter;

@end

@implementation BDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Setup CoreData
    
    [self kickstartUserDefaults];
    [self configureLogging];
    [self configureAccountsManager];

    // check if the user is logged in first
    if (self.accountsManager.isLoggedIn) {
        [self refreshUserData];
        
        BDKRoomsViewController *vc = [BDKRoomsViewController vc];
        UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
        self.window.rootViewController = nav;
    } else {
        [self setLoginControllerAsCenter];
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Save context
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Save context
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Save context?
    
}

#pragma mark - Methods

- (void)configureAccountsManager {
    self.accountsManager = [[MLLWAccountsManager alloc] init];
    [self.accountsManager configureLaunchpadWithClientId:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientKey]
                                            clientSecret:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientSecret]
                                             redirectUri:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsRedirectURI]];
}

- (void)setLoginControllerAsCenter {
    BDKLoginViewController *vc = [BDKLoginViewController vc];
    vc.userGotAuthCodeBlock = ^(NSString *authCode) {
        [self.accountsManager tradeAuthTokenDataForAuthorizationCode:authCode completion:^{
            [self refreshUserData];

            // transition this mofo a little better
            BDKRoomsViewController *vc = [BDKRoomsViewController vc];
            UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
            self.window.rootViewController = nav;
        } failure:^(NSError *error) {
            DDLogError(@"Error trading auth token. %@.", error);
        }];
    };
    UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
    self.window.rootViewController = nav;
}

- (void)kickstartUserDefaults {
    NSDictionary *userDefaults = (@{
                                    kBDKDefaultsDeviceIsiOS7: @([[UIApplication sharedApplication]
                                                                 respondsToSelector:@selector(setMinimumBackgroundFetchInterval:)]),
                                    kBDKDefaultsDeviceIs4Inch: @([[UIDevice currentDevice] is4Inch]),
                                    kBDKDefaultsDeviceIsPad: @([[UIDevice currentDevice] isPad]),
                                    });
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:userDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)configureLogging {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDTTYLogger sharedInstance].logFormatter = [[BDKLog alloc] init];
    [DDTTYLogger sharedInstance].colorsEnabled = YES;
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.60 green:0.81 blue:0.92 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.46 green:1.00 blue:0.48 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_API];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:0.60 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_UI];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithRed:0.87 green:0.67 blue:0.53 alpha:1.0]
                                     backgroundColor:nil forFlag:LOG_FLAG_DATA];
}

- (void)refreshUserData {
    [self.accountsManager refreshLaunchpadData:^{
        [self.accountsManager getAccountData:^{
            [self.accountsManager getCurrentUserData:^{
                [self.accountsManager getRooms:^(NSArray *rooms) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kBDKNotificationDidReloadRooms object:self];
                } failure:^(NSError *error) {
                    DDLogWarn(@"Error! %@", error);
                }];
            } failure:^(NSError *error) {
                DDLogWarn(@"Error! %@", error);
            }];
        } failure:^(NSError *error) {
            DDLogWarn(@"Error! %@", error);
        }];
    } failure:^(NSError *error) {
        //
    }];
}

- (void)signoutCurrentUser {
    [self.accountsManager signout];
    [self setLoginControllerAsCenter];
}

@end
