#import "IFBKCoreDataStore.h"

@implementation IFBKCoreDataStore

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [self storeWithName:@"IFBKModel"];
    });
    return _sharedInstance;
}

@end


@implementation NSManagedObjectContext (IFBKCoreDataStore)

+ (instancetype)defaultContext {
    return [[IFBKCoreDataStore sharedInstance] mainMOC];
}

@end