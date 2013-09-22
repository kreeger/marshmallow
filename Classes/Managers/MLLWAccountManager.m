#import "MLLWAccountManager.h"

#import "MLLWCoreDataStore.h"
#import "MLLWConstants.h"

#import "IFBKLPModels.h"
#import "IFBKCFModels.h"
#import "MLLWModels.h"

#import <IFBKThirtySeven/IFBKThirtySeven.h>
#import <BDKKit/BDKCoreDataOperation.h>

@interface MLLWAccountManager ()

/**
 The OAuth access token, used for connecting to both Launchpad and the Campfire API.
 */
@property (strong, nonatomic) NSString *accessToken;
/**
 The OAuth refresh token, used for refreshing the accessToken with the Launchpad API.
 */
@property (strong, nonatomic) NSString *refreshToken;
/**
 The date at which the current accessToken expires (and thus must be refreshed with the refreshToken).
 */
@property (strong, nonatomic) NSDate *expiresAt;

/**
 Handles fetching and saving Launchpad account data from the 37signals Launchpad API.
 
 @param completion A block to be called when the operation is complete.
 @param failure A block to be called when the operation encountered an error.
 */
- (void)retrieveAuthorizationData:(void (^)(void))completion failure:(void (^)(NSError *))failure;

/**
 */
- (void)storeUsers:(NSArray *)users completion:(void (^)(void))completion failure:(void (^)(NSError *))failure;

/**
 */
- (void)storeAccounts:(NSArray *)accounts completion:(void (^)(void))completion failure:(void (^)(NSError *))failure;

/**
 Common error-handling logic (including a standardized logging message).
 
 @param error The error handed back from the API.
 @param responseCode The response code handed back from the API.
 @param callback The callback method handed to the sending message.
 */
- (void)handleAPIError:(NSError *)error responseCode:(NSInteger)responseCode callback:(void (^)(NSError *))callback;

@end

@implementation MLLWAccountManager

@synthesize accessToken = _accessToken, refreshToken = _refreshToken, expiresAt = _expiresAt;

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    return self;
}

#pragma mark - Public properties

- (BOOL)isLoggedIn {
    return !!self.accessToken;
}

#pragma mark - Private properties

- (NSString *)accessToken {
    if (_accessToken) return _accessToken;
    _accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:MLLWUserDefaultAccessToken];
    [IFBKLaunchpadClient setBearerToken:_accessToken];
    return _accessToken;
}

- (void)setAccessToken:(NSString *)accessToken {
    [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:MLLWUserDefaultAccessToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [IFBKLaunchpadClient setBearerToken:accessToken];
    _accessToken = accessToken;
}

- (NSString *)refreshToken {
    if (_refreshToken) return _refreshToken;
    _refreshToken = [[NSUserDefaults standardUserDefaults] valueForKey:MLLWUserDefaultRefreshToken];
    return _refreshToken;
}

- (void)setRefreshToken:(NSString *)refreshToken {
    [[NSUserDefaults standardUserDefaults] setValue:refreshToken forKey:MLLWUserDefaultRefreshToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _refreshToken = refreshToken;
}

- (NSDate *)expiresAt {
    if (_expiresAt) return _expiresAt;
    _expiresAt = [[NSUserDefaults standardUserDefaults] valueForKey:MLLWUserDefaultTokenExpiresAt];
    return _expiresAt;
}

- (void)setExpiresAt:(NSDate *)expiresAt {
    [[NSUserDefaults standardUserDefaults] setValue:expiresAt forKey:MLLWUserDefaultTokenExpiresAt];
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
    DDLogAPI(@"Trading auth code %@.", authorizationCode);
    [IFBKLaunchpadClient getAccessTokenForVerificationCode:authorizationCode
                                                   success:^(NSString *accessT, NSString *refreshT, NSDate *expiresAt)
     {
         self.accessToken = accessT;
         self.refreshToken = refreshT;
         self.expiresAt = expiresAt;
         if (completion) {
             completion();
         }
     } failure:^(NSError *error, NSInteger responseCode) {
         [self handleAPIError:error responseCode:responseCode callback:failure];
     }];
}

- (void)refreshLaunchpadData:(void (^)(void))completion failure:(void (^)(NSError *error))failure {
    if ([self.expiresAt compare:[NSDate date]] == NSOrderedAscending) {
        [IFBKLaunchpadClient refreshAccessTokenWithRefreshToken:self.refreshToken
                                                        success:^(NSString *accessToken, NSDate *expiresAt)
         {
             self.accessToken = accessToken;
             self.expiresAt = expiresAt;
             [self retrieveAuthorizationData:completion failure:failure];
         } failure:^(NSError *error, NSInteger responseCode) {
             [self handleAPIError:error responseCode:responseCode callback:failure];
         }];
    } else {
        [self retrieveAuthorizationData:completion failure:failure];
    }
}

- (void)getAccounts:(void (^)(void))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.campfireAdapters count];
    NSMutableArray *mAccounts = [NSMutableArray arrayWithCapacity:count];
    __block NSInteger responses = 0;
    for (NSDictionary *clientPair in self.campfireAdapters) {
        NSNumber *identifier = clientPair[@"identifier"];
        IFBKCampfireClient *client = clientPair[@"client"];
        [client getCurrentAccount:^(IFBKCFAccount *account) {
            responses++;
            [mAccounts addObject:@{@"identifier": identifier, @"account": account}];
            if (responses == count) {
                [self storeAccounts:mAccounts completion:completion failure:failure];
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            responses++;
            if (failure) failure(error);
            if (responses == count) {
                [self storeAccounts:mAccounts completion:completion failure:failure];
            }
        }];
    }
}


- (void)getCurrentUsers:(void (^)(void))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.campfireAdapters count];
    NSMutableArray *mUsers = [NSMutableArray arrayWithCapacity:count];
    __block NSInteger responses = 0;
    for (NSDictionary *clientPair in self.campfireAdapters) {
        NSNumber *identifier = clientPair[@"identifier"];
        IFBKCampfireClient *client = clientPair[@"client"];
        [client getCurrentUser:^(IFBKCFUser *user) {
            responses++;
            [mUsers addObject:@{@"identifier": identifier, @"user": user}];
            if (responses == count) {
                [self storeUsers:mUsers completion:completion failure:failure];
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            responses++;
            if (failure) failure(error);
            if (responses == count) {
                [self storeUsers:mUsers completion:completion failure:failure];
            }
        }];
    }
}

- (void)getRooms:(void (^)(NSArray *rooms))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.campfireAccounts count];
    NSMutableArray *campfireRooms = [NSMutableArray arrayWithCapacity:count];
    for (MLLWAccount *account in self.campfireAccounts) {
        IFBKCampfireClient *campfire = [IFBKCampfireClient clientWithBaseURL:[account apiUrl]];
        [campfire setBearerToken:self.accessToken];
        [campfire getRooms:^(NSArray *result) {
            DDLogAPI(@"Got campfire rooms.");
            [campfireRooms addObject:@{@"account": account, @"rooms": result}];
            if (completion && count == [campfireRooms count]) {
                self.rooms = [NSArray arrayWithArray:campfireRooms];
                completion(self.rooms);
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

- (void)signout {
    self.accessToken = nil;
    self.refreshToken = nil;
    self.expiresAt = nil;
    
    [MLLWUser truncateAllInContext:[NSManagedObjectContext defaultContext]];
    [MLLWAccount truncateAllInContext:[NSManagedObjectContext defaultContext]];
    [MLLWLaunchpadAccount truncateAllInContext:[NSManagedObjectContext defaultContext]];
}

#pragma mark - Private methods

- (void)retrieveAuthorizationData:(void (^)(void))completion failure:(void (^)(NSError *))failure {
    [IFBKLaunchpadClient getAuthorizationData:^(IFBKLPAuthorizationData *authData) {
        NSMutableArray *mCampfires = [NSMutableArray arrayWithCapacity:[authData.accounts count]];
        [BDKCoreDataOperation performInBackgroundWithCoreDataStore:[MLLWCoreDataStore sharedInstance]
                                               backgroundOperation:^(NSManagedObjectContext *innerContext)
         {
             for (IFBKLPAccount *account in authData.accounts) {
                 MLLWLaunchpadAccount *lpAccount = [MLLWLaunchpadAccount createOrUpdateWithModel:account
                                                                                       inContext:innerContext];
                 IFBKCampfireClient *client = [IFBKCampfireClient clientWithBaseURL:lpAccount.hrefUrl];
                 [client setBearerToken:self.accessToken];
                 [mCampfires addObject:@{@"identifier": lpAccount.identifier, @"client": client}];
             }
             self.campfireAdapters = [mCampfires copy];
         } completion:^(BOOL success, NSError *error) {
             if (error) {
                 [self handleAPIError:error responseCode:0 callback:failure];
             } else {
                 if (completion) completion();
             }
         }];
    } failure:^(NSError *error, NSInteger responseCode) {
        [self handleAPIError:error responseCode:responseCode callback:failure];
    }];
}

- (void)storeAccounts:(NSArray *)accounts completion:(void (^)(void))completion failure:(void (^)(NSError *))failure {
    [BDKCoreDataOperation performInBackgroundWithCoreDataStore:[MLLWCoreDataStore sharedInstance]
                                           backgroundOperation:^(NSManagedObjectContext *innerContext)
     {
         for (NSDictionary *accountDict in accounts) {
             NSNumber *identifier = accountDict[@"identifier"];
             IFBKCFAccount *account = accountDict[@"account"];
             MLLWAccount *cAccount = [MLLWAccount createOrUpdateWithModel:account inContext:innerContext];
             MLLWLaunchpadAccount *lAccount = [MLLWLaunchpadAccount findByIdentifier:identifier
                                                                           inContext:innerContext];
             cAccount.launchpadAccount = lAccount;
         }
     } completion:^(BOOL success, NSError *error) {
         DDLogAPI(@"Campfire account data complete.");
         if (error) {
             if (failure) failure(error);
         } else if (completion) {
             completion();
         }
     }];
}

- (void)storeUsers:(NSArray *)users completion:(void (^)(void))completion failure:(void (^)(NSError *))failure {
    [BDKCoreDataOperation performInBackgroundWithCoreDataStore:[MLLWCoreDataStore sharedInstance]
                                           backgroundOperation:^(NSManagedObjectContext *innerContext)
     {
         for (NSDictionary *userDict in users) {
             NSNumber *identifier = userDict[@"identifier"];
             IFBKCFUser *user = userDict[@"user"];
             MLLWUser *cUser = [MLLWUser createOrUpdateWithModel:user inContext:innerContext];
             cUser.launchpadAccount = [MLLWLaunchpadAccount findByIdentifier:identifier inContext:innerContext];
         }
     } completion:^(BOOL success, NSError *error) {
         DDLogAPI(@"Campfire user data complete.");
         if (error) {
             if (failure) failure(error);
         } else if (completion) {
             completion();
         }
     }];
}

- (void)handleAPIError:(NSError *)error responseCode:(NSInteger)responseCode callback:(void (^)(NSError *))callback {
    DDLogWarn(@"MLLWAccountsManager response error %i: %@.", responseCode, [error localizedDescription]);
    if (callback) {
        callback(error);
    }
}

@end
