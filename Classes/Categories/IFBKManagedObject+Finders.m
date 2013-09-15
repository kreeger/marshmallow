#import "IFBKManagedObject+Finders.h"
#import "IFBKCoreDataStore.h"

@implementation IFBKManagedObject (Finders)

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate {
    return [self findWithPredicate:predicate inContext:[NSManagedObjectContext defaultContext]];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context {
    return [self findWithPredicate:predicate sortedBy:nil ascending:NO inContext:context];
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortProperty
                     ascending:(BOOL)flag
                     inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetch = [self fetchRequest];
    if (sortProperty) {
        fetch.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortProperty ascending:flag]];
    }
    if (predicate) {
        fetch.predicate = predicate;
    }
    NSError *error = nil;
    return [context executeFetchRequest:fetch error:&error];
}

+ (instancetype)findByIdentifier:(NSNumber *)identifier inContext:(NSManagedObjectContext *)context {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    NSArray *results = [self findWithPredicate:pred sortedBy:nil ascending:NO inContext:context];
    if ([results count] > 0) {
        return [results firstObject];
    } else {
        return nil;
    }
}

@end
