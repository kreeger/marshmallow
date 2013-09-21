#import <BDKKit/BDKCoreDataStore.h>

/**
 Handles all interaction with Core Data.
 */
@interface MLLWCoreDataStore : BDKCoreDataStore

/**
 Returns a singleton used for the Core Data store.
 
 @return The singleton instance.
 */
+ (instancetype)sharedInstance;

@end

@interface NSManagedObjectContext (IFBKCoreDataStore)

/**
 Provided for backwards compatibility. Returns the main-thread context.
 
 @return The main thread context.
 */
+ (instancetype)defaultContext;

@end