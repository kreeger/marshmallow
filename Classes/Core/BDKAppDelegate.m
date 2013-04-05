#import "BDKAppDelegate.h"
#import "BDKLoginViewController.h"
#import "BDKRoomsViewController.h"
#import "BDKMarshmallowAppearance.h"

#import "UINavigationController+BDKKit.h"

#import <CocoaLumberjack/DDTTYLogger.h>
#import <EDColor/UIColor+Crayola.h>

#import "BDKLaunchpadClient.h"
#import "BDKCampfireClient.h"
#import "BDKLPModels.h"
#import "BDKCFModels.h"
#import "BDKModels.h"

@interface BDKAppDelegate ()

/** Initializes user defaults.
 */
- (void)kickstartUserDefaults;

- (void)configureLogging;

- (void)setActiveAccount:(BDKLaunchpadAccount *)account;

@end

@implementation BDKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [self configureLogging];

    [BDKMarshmallowAppearance setApplicationAppearance];

    // check if the user is logged in first
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken]) {
        [self refreshUserData];
        
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

- (void)configureLogging {
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
    NSNumber *accountId = [[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultActiveAccountId];
    if (accountId && [BDKLaunchpadAccount countOfEntities] > 0) {
        [self setActiveAccount:[BDKLaunchpadAccount findFirstByAttribute:@"identifier" withValue:accountId]];
    } else {
        [BDKLaunchpadClient getAuthorization:^(BDKLPAuthorizationData *authData) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                [authData.accounts each:^(BDKLPAccount *account) {
                    [BDKLaunchpadAccount createOrUpdateWithModel:account inContext:localContext];
                }];
            } completion:^(BOOL success, NSError *error) {
                [self setActiveAccount:[BDKLaunchpadAccount findFirstByAttribute:@"product" withValue:@"campfire"]];
            }];
        } failure:^(NSError *error, NSInteger responseCode) {
            DDLogError(@"Error! %@.", error);
        }];
    }
}

- (void)setActiveAccount:(BDKLaunchpadAccount *)account
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kBDKNotificationDidBeginChangingAccount object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:account.identifier forKey:kBDKUserDefaultActiveAccountId];
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:kBDKUserDefaultAccessToken];
    DDLogData(@"Active account is now %@, token %@.", account.identifier, token);
    self.campfireClient = [[BDKCampfireClient alloc] initWithBaseURL:account.hrefUrl accessToken:token];
    
    [self.campfireClient getRooms:^(NSArray *result) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [result each:^(BDKCFRoom *room) {
                [BDKRoom createOrUpdateWithModel:room inContext:localContext];
            }];
        } completion:^(BOOL success, NSError *error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kBDKNotificationDidFinishChangingAccount object:nil];
            
            if ([((UINavigationController *)self.window.rootViewController).topViewController isKindOfClass:[BDKLoginViewController class]]) {
                BDKRoomsViewController *vc = [BDKRoomsViewController vc];
                UINavigationController *nav = [UINavigationController controllerWithRootViewController:vc];
                self.window.rootViewController = nav;
            }
        }];
    } failure:^(NSError *error, NSInteger responseCode) {
        DDLogError(@"Error! %@.", error);
    }];
    
    [self.campfireClient getCurrentAccount:^(BDKCFAccount *account) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [BDKAccount createOrUpdateWithModel:account inContext:localContext];
        }];
    } failure:^(NSError *error, NSInteger responseCode) {
        DDLogError(@"Error! %@.", error);
    }];

    [self.campfireClient getCurrentUser:^(BDKCFUser *user) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [BDKUser createOrUpdateWithModel:user inContext:localContext];
            [[NSUserDefaults standardUserDefaults] setValue:user.identifier forKey:kBDKUserDefaultCurrentUserId];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    } failure:^(NSError *error, NSInteger responseCode) {
        DDLogError(@"Error! %@.", error);
    }];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
