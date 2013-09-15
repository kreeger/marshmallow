#import "IFBKManagedObject.h"

/**
 Encapsulates all Core Data / Managed Object searching with predicates and the like.
 */
@interface IFBKManagedObject (Finders)

/**
 Finds all objects in a context with a given predicate. Uses the current context.
 
 @param predicate A predicate to use when searching for objects.
 @return An array of found objects.
 */
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate;

/**
 Finds all objects in a context with a given predicate.
 
 @param predicate A predicate to use when searching for objects.
 @param context The managed object context in which to search for results.
 @return An array of found objects.
 */
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context;

/**
 Convenience method for grabbing all objects with a sort parameter.
 
 @param predicate A predicate to use when searching for objects.
 @param sortProperty The string of the keypath by which to sort.
 @param flag If YES, the sort operation will be performed in an ascending manner.
 @param context The managed object context in which to search for results.
 @return An array of found objects, sorted.
 */
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate
                      sortedBy:(NSString *)sortProperty
                     ascending:(BOOL)flag
                     inContext:(NSManagedObjectContext *)context;

/**
 Short-hand method for finding a particular object with a given API identifier.
 
 @param identifier The API identifier to use when looking up an object.
 @param context The context to use when looking up an object.
 @return A matching object, if found.
 */
+ (instancetype)findByIdentifier:(NSNumber *)identifier inContext:(NSManagedObjectContext *)context;

@end
