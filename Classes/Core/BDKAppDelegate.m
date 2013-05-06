#import "BDKAppDelegate.h"
#import "BDKLoginViewController.h"
#import "BDKRoomsViewController.h"
#import "BDKMarshmallowAppearance.h"

#import "UINavigationController+BDKKit.h"

#import <CocoaLumberjack/DDTTYLogger.h>
#import <EDColor/UIColor+Crayola.h>
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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

- (void)configureAccountsManager
{
    self.accountsManager = [[IFBKAccountsManager alloc] init];
    [self.accountsManager configureLaunchpadWithClientId:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientKey]
                                            clientSecret:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsClientSecret]
                                             redirectUri:[BDKAPIKeyManager apiKeyForKey:kBDK37SignalsRedirectURI]];
}


- (void)kickstartUserDefaults
{
    NSDictionary *userDefaults = @{};
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)configureLogging
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDTTYLogger sharedInstance].logFormatter = [[BDKLog alloc] init];
    [DDTTYLogger sharedInstance].colorsEnabled = YES;
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithCrayola:@"Cornflower"]
                                     backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithCrayola:@"Screamin' Green"]
                                     backgroundColor:nil forFlag:LOG_FLAG_API];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithCrayola:@"Canary"]
                                     backgroundColor:nil forFlag:LOG_FLAG_UI];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor colorWithCrayola:@"Tumbleweed"]
                                     backgroundColor:nil forFlag:LOG_FLAG_DATA];
}

- (void)refreshUserData
{
    [self.accountsManager setAccessToken:[[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken]];
    [self.accountsManager refreshTokenAndAccounts:^{
        [self.accountsManager getAccountData:^(NSArray *accounts) {
            DDLogAPI(@"Accounts!!! %@", accounts);
            [self.accountsManager getRooms:^(NSDictionary *rooms) {
                DDLogAPI(@"ROOMS!!! %@", rooms);
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

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
