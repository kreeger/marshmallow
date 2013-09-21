#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@class IFBKCFModel;

/**
 A standard NSManagedObject class that gives the rest of our Core Data models some cohesiveness.
 */
@interface MLLWManagedObject : NSManagedObject

/**
 A common implementation to return entity name. Used in fetches and the like. Default implementation returns a string
 version of the name of the class.
 
 @return The string of the name of the entity.
 */
+ (NSString *)entityName;

/**
 A common implementation to return an entity description object. Used in fetches and the like.
 
 @param context The context to use when providing an entity description.
 @return A proper entity description.
 */
+ (NSEntityDescription *)entityDescriptionForContext:(NSManagedObjectContext *)context;

/**
 A common implementation to return an easy-to-use fetch request object.
 
 @return An NSFetchRequest already set to the current class's entity name.
 */
+ (NSFetchRequest *)fetchRequest;

/**
 The main method to call when dealing with a Core Data representation of an API model.
 
 @param model The API model to use in looking up to see if it exists.
 @param context The managed object context; can be nil (if so, the default is used).
 @return An instance of self.
 */
+ (instancetype)createOrUpdateWithModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context;

/**
 Initializes this model with a IFBKCFModel.
 
 @param model The IFBKCFModel with which to create this model.
 @param context The managed object context; can be nil (if so, the default is used).
 @return An instance of self.
 */
+ (instancetype)modelWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context;

/**
 Deletes all with the entity type in the database.
 */
+ (void)truncateAll;

/**
 Initializes this model with a IFBKCFModel.
 
 @param model The IFBKCFModel with which to create this model.
 @param context the managed object context; can be nil (if so, the default is used).
 @return An instance of self.
 */
- (instancetype)initWithIFBKCFModel:(IFBKCFModel *)model inContext:(NSManagedObjectContext *)context;

/**
 Updates internal parameters with a IFBKCFModel instance; this must be implemented by child classes.
 
 @param model The IFBKCFModel with which to update this model.
 */
- (void)updateWithIFBKCFModel:(IFBKCFModel *)model;

@end

/**
 Encapsulates all Core Data / Managed Object searching with predicates and the like.
 */
@interface MLLWManagedObject (Finders)

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

