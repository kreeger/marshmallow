#import "BDKAPIKeyManager.h"

NSString * const BDK37SignalsClientKey = @"37SignalsClientKey";
NSString * const BDK37SignalsClientSecret = @"37SignalsClientSecret";
NSString * const BDK37SignalsRedirectURI = @"37SignalsRedirectURI";

@interface BDKAPIKeyManager ()

@property (strong, nonatomic) NSDictionary *apiKeys;

@end

@implementation BDKAPIKeyManager

#pragma mark - Initialization and singleton

+ (instancetype)sharedInstance {
    static BDKAPIKeyManager *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [BDKAPIKeyManager new];
    });
    return __sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"APIKeys" ofType:@"plist"];
    _apiKeys = [NSDictionary dictionaryWithContentsOfFile:path];
    return self;
}

+ (NSString *)apiKeyForKey:(NSString *)key {
    return [[self sharedInstance] apiKeys][key];
}

@end
