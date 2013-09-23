#import "MLLWCoreDataStore.h"

@implementation MLLWCoreDataStore

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self storeWithName:@"MLLWModel"];
    });
    return _sharedInstance;
}

@end


@implementation NSManagedObjectContext (IFBKCoreDataStore)

+ (instancetype)defaultContext {
    return [[MLLWCoreDataStore sharedInstance] mainMOC];
}

@end