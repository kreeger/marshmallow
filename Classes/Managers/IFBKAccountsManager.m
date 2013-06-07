#import "IFBKAccountsManager.h"

#import "IFBKConstants.h"

#import "IFBKLPModels.h"
#import "IFBKCFModels.h"
#import "IFBKModels.h"

#import <IFBKThirtySeven/IFBKThirtySeven.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord.h>

@interface IFBKAccountsManager ()

/** The OAuth access token, used for connecting to both Launchpad and the Campfire API.
 */
@property (strong, nonatomic) NSString *accessToken;

/** The OAuth refresh token, used for refreshing the accessToken with the Launchpad API.
 */
@property (strong, nonatomic) NSString *refreshToken;

/** The date at which the current accessToken expires (and thus must be refreshed with the refreshToken).
 */
@property (strong, nonatomic) NSDate *expiresAt;

@end

@implementation IFBKAccountsManager

@synthesize accessToken = _accessToken, refreshToken = _refreshToken, expiresAt = _expiresAt;

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public properties

- (BOOL)isLoggedIn {
    return self.accessToken != nil;
}

#pragma mark - Private properties

- (NSString *)accessToken {
    if (_accessToken) return _accessToken;
    _accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:kIFBKUserDefaultAccessToken];
    [IFBKLaunchpadClient setBearerToken:_accessToken];
    return _accessToken;
}

- (void)setAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:kIFBKUserDefaultAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [IFBKLaunchpadClient setBearerToken:accessToken];
    _accessToken = accessToken;
}

- (NSString *)refreshToken {
    if (_refreshToken) return _refreshToken;
    _refreshToken = [[NSUserDefaults standardUserDefaults] valueForKey:kIFBKUserDefaultRefreshToken];
    return _refreshToken;
}

- (void)setRefreshToken:(NSString *)refreshToken {
    [[NSUserDefaults standardUserDefaults] setValue:refreshToken forKey:kIFBKUserDefaultRefreshToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _refreshToken = refreshToken;
}

- (NSDate *)expiresAt {
    if (_expiresAt) return _expiresAt;
    _expiresAt = [[NSUserDefaults standardUserDefaults] valueForKey:kIFBKUserDefaultTokenExpiresAt];
    return _expiresAt;
}

- (void)setExpiresAt:(NSDate *)expiresAt {
    [[NSUserDefaults standardUserDefaults] setValue:expiresAt forKey:kIFBKUserDefaultTokenExpiresAt];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _expiresAt = expiresAt;
}

#pragma mark - Public methods

- (void)configureLaunchpadWithClientId:(NSString *)clientId
                          clientSecret:(NSString *)clientSecret
                           redirectUri:(NSString *)redirectUri {
    [IFBKLaunchpadClient setClientId:clientId clientSecret:clientSecret redirectUri:redirectUri];
}

- (void)tradeAuthTokenDataForAuthorizationCode:(NSString *)authorizationCode
                                    completion:(void (^)(void))completion
                                       failure:(void (^)(NSError *error))failure {
    NSLog(@"Trading auth code %@.", authorizationCode);
    [IFBKLaunchpadClient getAccessTokenForVerificationCode:authorizationCode
                                                   success:^(NSString *accessToken, NSString *refreshToken, NSDate *expiresAt) {
                                                       // Do something else with these.
                                                       self.accessToken = accessToken;
                                                       self.refreshToken = refreshToken;
                                                       self.expiresAt = expiresAt;
                                                       if (completion) completion();
                                                   } failure:^(NSError *error, NSInteger responseCode) {
                                                       if (failure) failure(error);
                                                   }];
}

- (void)refreshLaunchpadData:(void (^)(void))completion failure:(void (^)(NSError *error))failure {
    // TODO: also check expiresOn is less than today
    __block void (^refreshBlock)(void) = ^{
        [IFBKLaunchpadClient getAuthorization:^(IFBKLPAuthorizationData *authData) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                for (IFBKCFAccount *account in authData.accounts) {
                    [IFBKLaunchpadAccount createOrUpdateWithModel:account inContext:localContext];
                }
            } completion:^(BOOL success, NSError *error) {
                // We only want Campfire ones!
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product = %@", @"campfire"];
                self.launchpadAccounts = [IFBKLaunchpadAccount findAllWithPredicate:predicate];
                if (completion) completion();
            }];
        } failure:^(NSError *error, NSInteger responseCode) {
            NSLog(@"Error! %@.", error);
            if (failure) failure(error);
        }];
    };

    if ([self.expiresAt compare:[NSDate date]] == NSOrderedAscending) {
        [IFBKLaunchpadClient refreshAccessTokenWithRefreshToken:self.refreshToken
                                                        success:^(NSString *accessToken, NSDate *expiresAt) {
                                                            self.accessToken = accessToken;
                                                            self.expiresAt = expiresAt;
                                                            refreshBlock();
                                                        } failure:^(NSError *error, NSInteger responseCode) {
                                                            if (failure) failure(error);
                                                        }];
    } else refreshBlock();
}

- (void)getAccountData:(void (^)(NSArray *accounts))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.launchpadAccounts count];
    NSMutableArray *campfireAccounts = [NSMutableArray arrayWithCapacity:count];
    for (IFBKLaunchpadAccount *lpAccount in self.launchpadAccounts) {
        __block NSNumber *identifier = nil;
        IFBKCampfireClient *campfire = [IFBKCampfireClient clientWithBaseURL:lpAccount.hrefUrl];
        [campfire setBearerToken:self.accessToken];
        [campfire getCurrentAccount:^(IFBKCFAccount *account) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                IFBKAccount *cAccount = [IFBKAccount createOrUpdateWithModel:account inContext:localContext];
                cAccount.launchpadAccount = [lpAccount inContext:localContext];
                identifier = cAccount.identifier;
            } completion:^(BOOL success, NSError *error) {
                IFBKAccount *cAccount = [IFBKAccount findFirstByAttribute:@"identifier" withValue:identifier];
                [campfireAccounts addObject:cAccount];
                if (completion && count == [campfireAccounts count]) {
                    self.campfireAccounts = campfireAccounts;
                    completion(self.campfireAccounts);
                }
            }];
        } failure:^(NSError *error, NSInteger responseCode) {
            if (failure) failure(error);
        }];
    }
}

- (void)getCurrentUserData:(void (^)(NSArray *accounts))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.launchpadAccounts count];
    NSMutableArray *currentUsers = [NSMutableArray arrayWithCapacity:count];
    for (IFBKLaunchpadAccount *account in self.launchpadAccounts) {
        __block NSNumber *identifier = nil;
        IFBKCampfireClient *campfire = [IFBKCampfireClient clientWithBaseURL:account.hrefUrl];
        [campfire setBearerToken:self.accessToken];
        [campfire getCurrentUser:^(IFBKCFUser *user) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                IFBKUser *cUser = [IFBKUser createOrUpdateWithModel:user inContext:localContext];
                cUser.launchpadAccount = [account inContext:localContext];
                identifier = cUser.identifier;
            } completion:^(BOOL success, NSError *error) {
                IFBKUser *cUser = [IFBKUser findFirstByAttribute:@"identifier" withValue:identifier];
                [currentUsers addObject:cUser];
                if (completion && count == [currentUsers count]) {
                    self.campfireUsers = currentUsers;
                    completion(self.campfireUsers);
                }
            }];
        } failure:^(NSError *error, NSInteger responseCode) {
            if (failure) failure(error);
        }];
    }
}

- (void)getRooms:(void (^)(NSArray *rooms))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.campfireAccounts count];
    NSMutableArray *campfireRooms = [NSMutableArray arrayWithCapacity:count];
    for (IFBKAccount *account in self.campfireAccounts) {
        IFBKCampfireClient *campfire = [IFBKCampfireClient clientWithBaseURL:[account apiUrl]];
        [campfire setBearerToken:self.accessToken];
        [campfire getRooms:^(NSArray *result) {
            [campfireRooms addObject:@{@"account": account, @"rooms": result}];
            if (completion && count == [campfireRooms count]) {
                self.rooms = [NSArray arrayWithArray:campfireRooms];
                completion(self.rooms);
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            if (failure) failure(error);
        }];
    }
}

- (void)signout {
    self.accessToken = nil;
    self.refreshToken = nil;
    self.expiresAt = nil;
    [IFBKUser truncateAll];
    [IFBKAccount truncateAll];
    [IFBKLaunchpadAccount truncateAll];
}

@end
