#import "IFBKAccountsManager.h"

#import "BDKLaunchpadClient.h"
#import "BDKCampfireClient.h"

#import "BDKLPModels.h"
#import "BDKCFModels.h"
#import "IFBKModels.h"

@interface IFBKAccountsManager ()

/** The OAuth access token, used for connecting to both Launchpad and the Campfire API.
 */
@property (strong, nonatomic) NSString *accessToken;

@end

@implementation IFBKAccountsManager

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Setup methods

- (void)configureLaunchpadWithClientId:(NSString *)clientId
                          clientSecret:(NSString *)clientSecret
                           redirectUri:(NSString *)redirectUri {
    [BDKLaunchpadClient setClientId:clientId clientSecret:clientSecret redirectUri:redirectUri];
}

- (void)setAccessToken:(NSString *)accessToken {
    [BDKLaunchpadClient setBearerToken:accessToken];
    _accessToken = accessToken;
}

- (void)refreshTokenAndAccounts:(void (^)(void))completion failure:(void (^)(NSError *error))failure {
    [BDKLaunchpadClient getAuthorization:^(BDKLPAuthorizationData *authData) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [authData.accounts each:^(BDKLPAccount *account) {
                [IFBKLaunchpadAccount createOrUpdateWithModel:account inContext:localContext];
            }];
        } completion:^(BOOL success, NSError *error) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product = %@", @"campfire"];
            self.launchpadAccounts = [IFBKLaunchpadAccount findAllWithPredicate:predicate];
            if (completion) completion();
        }];
    } failure:^(NSError *error, NSInteger responseCode) {
        DDLogError(@"Error! %@.", error);
        if (failure) failure(error);
    }];
}

- (void)getAccountData:(void (^)(NSArray *accounts))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.launchpadAccounts count];
    NSMutableArray *campfireAccounts = [NSMutableArray arrayWithCapacity:count];
    for (IFBKLaunchpadAccount *account in self.launchpadAccounts) {
        __block NSNumber *identifier = nil;
        BDKCampfireClient *campfire = [BDKCampfireClient clientWithBaseURL:account.hrefUrl];
        [campfire setBearerToken:self.accessToken];
        [campfire getCurrentAccount:^(BDKCFAccount *account) {
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                IFBKAccount *cAccount = [IFBKAccount createOrUpdateWithModel:account inContext:localContext];
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

- (void)getRooms:(void (^)(NSArray *rooms))completion failure:(void (^)(NSError *error))failure {
    NSInteger count = [self.campfireAccounts count];
    NSMutableArray *campfireRooms = [NSMutableArray arrayWithCapacity:count];
    for (IFBKAccount *account in self.campfireAccounts) {
        BDKCampfireClient *campfire = [BDKCampfireClient clientWithBaseURL:[account apiUrl]];
        [campfire setBearerToken:self.accessToken];
        [campfire getRooms:^(NSArray *result) {
            [campfireRooms addObject:@{@"title": account.name, @"rooms": result}];
            if (completion && count == [campfireRooms count]) {
                self.rooms = [NSArray arrayWithArray:campfireRooms];
                completion(self.rooms);
            }
        } failure:^(NSError *error, NSInteger responseCode) {
            if (failure) failure(error);
        }];
    }
}

@end
