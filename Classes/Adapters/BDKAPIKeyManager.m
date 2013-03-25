#import "BDKAPIKeyManager.h"

@interface BDKAPIKeyManager ()

@property (strong, nonatomic) NSDictionary *apiKeys;

@end

@implementation BDKAPIKeyManager

#pragma mark - Initialization and singleton

+ (id)sharedInstance {
    static BDKAPIKeyManager *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[BDKAPIKeyManager alloc] init];
    });
    return __sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _apiKeys = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"APIKeys"
                                                                                              ofType:@"plist"]];
    }
    return self;
}

+ (NSString *)apiKeyForKey:(NSString *)key {
    return [[self sharedInstance] apiKeys][key];
}

@end
