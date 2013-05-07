#import "BDKAppDelegate.h"
#import "BDKLoginViewController.h"
#import "BDKRoomsViewController.h"
#import "BDKMarshmallowAppearance.h"

#import "UINavigationController+BDKKit.h"

#import <CocoaLumberjack/DDTTYLogger.h>
#import <CrittercismSDK/Crittercism.h>

#import "BDKAPIKeyManager.h"
#import "IFBKAccountsManager.h"

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

@end

@implementation BDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [Crittercism enableWithAppID:@"5180531c5f7216216f000003"];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [self configureLogging];
    [self configureAccountsManager];

    [BDKMarshmallowAppearance setApplicationAppearance];

    // check if the user is logged in first
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken]) {
        [self.accountsManager setAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken]];
        [self refreshUserData];
        
        BDKRoomsViewController *vc = [BDKRoomsViewController vc];
        UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
        self.window.rootViewController = nav;
    } else {
        BDKLoginViewController *vc = [BDKLoginViewController vc];
        vc.userDidLoginBlock = ^(NSString *accessToken) {
            [self refreshUserData];
            // transition this mofo a little better
            BDKRoomsViewController *vc = [BDKRoomsViewController vc];
            UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
            self.window.rootViewController = nav;
        };
        UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
        self.window.rootViewController = nav;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

#pragma mark - Methods

- (void)configureAccountsManager {
    self.accountsManager = [[IFBKAccountsManager alloc] init];
    [self.accountsManager configureLaunchpadWithClientId:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientKey]
                                            clientSecret:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientSecret]
                                             redirectUri:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsRedirectURI]];
}


- (void)kickstartUserDefaults {
    NSDictionary *userDefaults = @{};
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
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
    [self.accountsManager setAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken]];
    [self.accountsManager refreshTokenAndAccounts:^{
        [self.accountsManager getAccountData:^(NSArray *accounts) {
            [self.accountsManager getRooms:^(NSArray *rooms) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kBDKNotificationDidReloadRooms object:self];
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

@end
