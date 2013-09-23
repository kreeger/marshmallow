#import "BDKAppDelegate.h"

#import "BDKLoginViewController.h"
#import "BDKRoomsViewController.h"

#import "BDKAPIKeyManager.h"
#import "BDKConstants.h"
#import "MLLWAccountManager.h"
#import "BDKLog.h"

#import <BDKKit/UINavigationController+BDKKit.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <BDKKit/UIDevice+BDKKit.h>

@interface BDKAppDelegate ()

@property (strong, nonatomic) BDKRoomsViewController *roomsVC;

/**
 Initializes user defaults.
 */
- (void)kickstartUserDefaults;

/**
 Sets up our common Launchpad instance with the proper OAuth keys.
 */
- (void)configureAccountsManager;

/**
 Presents the login view controller as the main center view controller.
 */
- (void)setLoginControllerAsCenter;

@end

@implementation BDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.tintColor = [UIColor orangeColor];
    [self kickstartUserDefaults];
    [BDKLog configureLogging];
    [self configureAccountsManager];

    // check if the user is logged in first
    if (self.accountManager.isLoggedIn) {
        [self refreshUserData];
        
        self.roomsVC = [BDKRoomsViewController new];
        UINavigationController *nav = [UINavigationController controllerWithRootViewController:self.roomsVC];
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
    self.accountManager = [MLLWAccountManager new];
    [self.accountManager configureLaunchpadWithClientId:[BDKAPIKeyManager apiKeyForKey:BDK37SignalsClientKey]
                                            clientSecret:[BDKAPIKeyManager apiKeyForKey:BDK37SignalsClientSecret]
                                             redirectUri:[BDKAPIKeyManager apiKeyForKey:BDK37SignalsRedirectURI]];
}

- (void)setLoginControllerAsCenter {
    BDKLoginViewController *vc = [BDKLoginViewController new];
    vc.userGotAuthCodeBlock = ^(NSString *authCode) {
        [self.accountManager tradeAuthTokenDataForAuthorizationCode:authCode completion:^{
            [self refreshUserData];

            // transition this mofo a little better
            self.roomsVC = [BDKRoomsViewController new];
            UINavigationController *nav = [UINavigationController controllerWithRootViewController:self.roomsVC];
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
                                    BDKDefaultsDeviceIsiOS7: @([[UIApplication sharedApplication]
                                                                 respondsToSelector:@selector(setMinimumBackgroundFetchInterval:)]),
                                    BDKDefaultsDeviceIs4Inch: @([[UIDevice currentDevice] is4Inch]),
                                    BDKDefaultsDeviceIsPad: @([[UIDevice currentDevice] isPad]),
                                    });
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
    [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:userDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)refreshUserData {
    [self.accountManager refreshLaunchpadData:^{
        void (^callback)(void) = ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.roomsVC refreshRooms];
            });
        };
        [self.accountManager getRooms:^(NSArray *rooms) {
            callback();
        } failure:nil];
        [self.accountManager getAccounts:callback failure:nil];
        
        [self.accountManager getCurrentUsers:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.roomsVC enableProfileButton:YES];
            });
        } failure:nil];
        
    } failure:^(NSError *error) {
        //
    }];
}

- (void)signoutCurrentUser {
    [self.accountManager signout];
    [self setLoginControllerAsCenter];
}

@end
